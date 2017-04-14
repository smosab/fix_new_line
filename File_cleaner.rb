require 'csv'
require 'pry'
require 'html_to_plain_text'

csv_files = Dir["sandbox/*.TXT"] #File or extension to look for

@delim = "|"
@regex_delim = Regexp.new(Regexp.escape(@delim))

# this method removes any delimiting characters being used to seperate fields from within each field(mainly from text/comment fields) 
def remove_delim(row)
	row.each do |f|
		f.gsub!(/@regex_delim|\r\n|\r|\n|\\/,'') if f
	end
	row
end

def decode_html(row)
	if row[9]
		row[9] = HtmlToPlainText
				.plain_text(row[9])
				.gsub!(/[^0-9A-Za-z:\s()_\[\]!@#$%^&*\/+-={}~;'.,]/, '')
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

csv_files.each do |file|
	
	escape_illegal_characters(file)

	CSV.open("#{file}.out", "w", {:col_sep => @delim}) do |csv_obj|
		CSV.foreach("#{file}.tmp", {:headers => false, :col_sep => @delim } ).with_index do |row, i|
			csv_obj << fix(row).each {|row| row.force_encoding("IBM437") if row }
		end

	end

end