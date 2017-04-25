starttime = Time.new

require 'csv'
require 'pry'
require 'html_to_plain_text'

@filename = 'file_notes.csv' # specify the file name here
@client = "ermcgl"
@source = "carlwarren"
@env = Dir.exists?("sandbox") ? "sandbox/" : nil

# @csv_files = Dir.exists?(@env) ? Dir["#{@env}/#{@filename}"] : Dir["#{@filename}"]    #Modify the last Dir entry with the correct file or extension.

@csv_files = Dir["#{@env}#{@filename}"]

@delim = "|"
@regex_delim = Regexp.new(Regexp.escape(@delim))

# this method removes any delimiting characters being used to seperate fields from within each field(mainly from text/comment fields) 
def remove_delim(row)

	row.each do |f|
		f.gsub!(/@regex_delim|\r\n|\r|\n|\\/,'') if f
	end
	row
end

def contains_special_chars?(field)
	field.match /[^0-9A-Za-z:\s()_\[\]!@#$%^&*\/+-={}~;'.,]/
end

def decode_html(row)
# binding.pry
		# row[9] = HtmlToPlainText
		# 		.plain_text(row[9]) if row[9]
				#.gsub!(/[^0-9A-Za-z:\s()_\[\]!@#$%^&*\/+-={}~;'.,]/, '') if row[9] && contains_special_chars?(row[9])

		# row[10] = HtmlToPlainText
		# 		.plain_text(row[10]) if row[9]
				#.gsub!(/[^0-9A-Za-z:\s()_\[\]!@#$%^&*\/+-={}~;'.,]/, '') if row[10] && contains_special_chars?(row[10])

	row.each_with_index do |f,i|
		row[i] = HtmlToPlainText.plain_text(row[i]) if f
	end

end


def fix(row)
	decode_html(row)
	remove_delim(row)
end

def escape_illegal_characters(file)
	contents = ''
	File.open("#{file}", "r+b") do |f|

		contents = f.read
		contents.gsub! /"/,''
		contents.gsub! /\\(?=#@regex_delim)/ , ''
		out = File.new("#{f.path}.tmp", "w+b")
		out.syswrite(contents)
		out.close
	end
	
end

def fixgb

	CSV.open("#{@env}#{@client}notes.fixgb", "w", {:col_sep => @delim}) do |csv_obj|

			oldclaim_num, oldnote_date, olduser_inits, oldnote_type_code = "00000", "00/00/0000", "", ""
			
			temp_row = []

			CSV.foreach("#{@env}#{@client}notes.txt", {:headers => false, :col_sep => @delim } ).with_index do |row, rownumber|
				
				claim_num, note_date, user_inits, note_type_code, sequence_num, ntext = row
				temp_row = claim_num, note_date, user_inits, note_type_code, ntext if temp_row.empty?
				#temp_row ||= claim_num, note_date, user_inits, note_type_code, ntext

				if claim_num == oldclaim_num &&
					note_date == oldnote_date &&
					user_inits == olduser_inits &&
					note_type_code == oldnote_type_code &&
					sequence_num != "001"

					temp_row[4] << ntext

				else
					csv_obj << temp_row
					temp_row = []
				end
				
				oldclaim_num, oldnote_date, olduser_inits = row[0..2]

			end
		end
end

def formatgb

	File.open("#{@env}#{@client}notes.formatgb", "w") do |file|

			oldclaim_num, oldnote_date, olduser_inits, oldnote_type_code = "00000", "00/00/0000", "", ""
			@i = 1
			pntext = ""

			CSV.foreach("#{@env}#{@client}notes.fixgb", {:headers => false, :col_sep => @delim } ).with_index do |row, rownumber|
				
				claim_num, note_date, user_inits, note_type_code, ntext = row
				note_head = "#{@source.upcase}:#{note_date} #{user_inits.ljust(15, " ")}"

				# note_head = sprintf "#{@source.upper}:%s %-15s", note_date, user_inits
				
				pntext = note_head + ntext.to_s

				oldclaim_num, oldnote_date, olduser_inits, oldnote_type_code = row[0..3]

				# print the polnum, the counter, and the first 78 chars of the pntext.
				# loop to get the next 78, increment the counter, and so on.
				
				loop do
					# binding.pry
					newrow = sprintf "%-30s%-3s%2s%-78s\n", claim_num, note_type_code, @i, pntext.slice!(0..77)
					file << newrow
					pntext.empty? ? @i = 1 : @i += 1 
						if @i >= 52
							@i = 1
							pntext = note_head + ntext
						end

					break unless pntext.size > 0
				end

			end
		end
end

def run_cleaner
	@csv_files.each do |file|
	
		escape_illegal_characters(file)
		
		CSV.open("#{file}.out", "w", {:col_sep => @delim}) do |csv_obj|
			CSV.foreach("#{file}.tmp", {:headers => false, :col_sep => @delim } ).with_index do |row, i|

				csv_obj << fix(row).each {|row| row.force_encoding("IBM437") if row }
			end
		end

		File.delete("#{file}.tmp")

	end

end


#run_cleaner
fixgb
formatgb

endtime = Time.new
duration = endtime - starttime

puts duration/60
