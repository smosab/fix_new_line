require 'csv'
require 'pry'

def	remove_double_quotes(contents)
	loop do
	
		break unless contents.match /([^^\t\n])(")([^\t\n])/
		contents.gsub!(/([^^\t\n])(")([^\t\n])/, '\1\3')
	end
end

def	remove_crlf(contents)
	contents.gsub!(/\r\n/,'')
end
		
csv_files = Dir["airgas*.txt"]
	
csv_files.each do |file|
	contents = ''
	File.open("#{file}", "r+b") do |f| 
		contents = f.read
		remove_crlf(contents)
		remove_double_quotes(contents)
		out = File.new("#{f.path}.out", "w+b")
		out.syswrite(contents)
		out.close
	end

	CSV.foreach("#{file}.out", {:col_sep => "\t"}) do |row| #, :quote_char => '"'

		CSV.open("#{file}.final", "ab",{:col_sep => "\t"}) do |csv_obj|  #, :quote_char => ' ' , converters: :numeric
		# binding.pry
			new_notes = ''
		
			if !!row[3]
				
					# if row[3].empty?
						# new_notes = new_notes + "\t"
						loop do
							new_notes = new_notes + row[3][0..78] + "\t"
							row[3].slice!(0,78)
						break if row[3].empty?
						end
			end
			
			tab_count = new_notes.count("\t")
			(89-tab_count).times do
				new_notes += "\t"
			end
			
			csv_obj << [row[0],row[1],row[2], new_notes]
		end

		
	end
	File.delete "#{file}.out"
end
