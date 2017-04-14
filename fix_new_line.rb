require 'csv'
require 'pry';'pry-nav'



csv_files = Dir["DATA_CLAIM_PRG_NOTE.TXT"] #File extension to look for

# this method removes any delimiting characters being used to seperate fields from within each field(mainly from text/comment fields) 
def remove_delim(row, delim)

	CSV.parse_line(row, {col_sep: delim}).map { |f| f == "" ? nil : f != nil && f.include?(delim) ? f.gsub!(delim, '') : f }
end

def remove_double_quotes(row, delim)

    regex = /([^^#{Regexp.quote(delim)}\n])(")([^#{Regexp.quote(delim)}\n])/
    
    loop do
      break unless row.match(regex)
      row.gsub!(regex, '\1\3')
    end
    row
end

def unquoted?(row, delim)
	begin
		CSV.parse_line(row, {col_sep: delim}) #$!.class == CSV::MalformedCSVError
	rescue 
		true
	else
		false
	end

end

def fix_rows(contents, file, delim, num_fields)
	#new_contents_arr = []
	Dir.mkdir("fixed_new_line") unless Dir.exist?("fixed_new_line")

	CSV.open("fixed_new_line/#{file}.final", "wb",{:col_sep => delim, :headers => true}) do |csv_obj|

		fixed_row = ''

		contents.each do |row|
			
			row = remove_double_quotes(row, delim)
			
			if	row.split(delim).size != num_fields || !row.include?(delim) || unquoted?(row, delim) 
				
				fixed_row += row.match(/\n|\r|\r\n/) ? row.gsub(/\n|\r|\r\n/, '') : row
				if fixed_row.split(delim).size == num_fields && row.include?(delim) && !unquoted?(row, delim) 
					# binding.pry if row.include?("000880000026437")
					csv_obj << remove_delim(fixed_row, delim)

					fixed_row = ''
				end
			else
				
				#add valid row to new array and go to next array element (row)
				csv_obj << remove_delim(row, delim)
				next
			end
		end

	end
end

def detect_delimiter(sample_rows)
	delimiter_count = {
		"|" => sample_rows.join.count("|"), 
		"," => sample_rows.join.count(","), 
		"\t" => sample_rows.join.count("\t") 
	}

	delimiter_count.max_by {|k,v| v}[0]
end

def detect_num_fields(sample_rows, delim)

	# begin
	# 	sample_rows.map {|row| CSV.parse_line(row, {col_sep: delim}) }.max #$!.class == CSV::MalformedCSVError
	# rescue 
	# 	sample_rows.map {|row| row.split(delim).count }.max
	# else
	# 	false
	# end
	row_number_groups = sample_rows.map {|row| row.split(delim).count}.each_with_object({}) {|n, h| h[n].nil? ? h[n] = 1 : h[n] = h[n] + 1 }
	row_number_groups.key(row_number_groups.values.max)
			
end

def remove_invalid_chars(contents_arr)
	contents_arr.each {|row| row.gsub!(/\r\n|\\/,'') if row.match /\r\n|\\/ }
end

csv_files.each do |file|
	
	# contents = File.read("#{file}")
	
    contents_arr = IO.readlines("#{file}") #, "#{@eol}")
	remove_invalid_chars(contents_arr)

	# contents_arr = IO.readlines(contents)
    delim = detect_delimiter(contents_arr[0..10])
    num_fields = detect_num_fields(contents_arr[0..10], delim)
   	fix_rows(contents_arr, file, delim, num_fields)

end