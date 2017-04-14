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

csv_files = Dir["*.csv"]

csv_files.each do |file|
	contents = ''
	File.open("#{file}", "r+b") do |f|
		contents = f.read
		# remove_crlf(contents)
		# remove_double_quotes(contents)
		out = File.new("#{f.path}.out", "w+b")
		out.syswrite(contents)
		out.close
	end
	
	File.delete "#{file}.final" if File.exists? "#{file}.final"
	# highest_tab_count = 0
	binding.pry
	CSV.foreach("#{file}.out", {:col_sep => "\t"}) do |row| #, :quote_char => '"'
	
		CSV.open("#{file}.final", "ab",{:col_sep => "\t"}) do |csv_obj|  #, :quote_char => ' ' , converters: :numeric, force_quotes: true
		
			new_notes = ''
			if row[3]

					# if row[3].empty?
						# new_notes = new_notes + "\t"
						
						##tab seprate as is
						# loop do
							# new_notes = new_notes + row[3][0..78] + "\t"
							# row[3].slice!(0,79)
						# break if row[3].empty?
						# end
						
						#tab seperate with double quotes
										
						loop do
						
							new_notes = new_notes + "'" + row[3][0..76] + "'\t"
							row[3].slice!(0,77)
						break if row[3].empty?
						end
						current_tab_count = new_notes.count("\t")
						
			end
			# set highest tab count = tab count of first row
			#if the tab count of the second row is greater, then set the highest tab count variable equal to that
			#repeat for the rest of the rows
			# binding.pry if current_tab_count == nil
			
			# if current_tab_count.to_i > highest_tab_count
				# highest_tab_count = current_tab_count
			# end
			
			# (89-tab_count).times do
				# new_notes += "\t"
			# end
			
			new_notes_arr = new_notes.split("\t")

			csv_obj << [row[0],row[1],row[2],new_notes_arr[0],new_notes_arr[1],new_notes_arr[2],new_notes_arr[3],new_notes_arr[4],new_notes_arr[5],new_notes_arr[6],new_notes_arr[7],new_notes_arr[8],new_notes_arr[9],new_notes_arr[10],new_notes_arr[11],new_notes_arr[12],new_notes_arr[13],new_notes_arr[14],new_notes_arr[15],new_notes_arr[16],new_notes_arr[17],new_notes_arr[18],new_notes_arr[19],new_notes_arr[20],new_notes_arr[21],new_notes_arr[22],new_notes_arr[23],new_notes_arr[24],new_notes_arr[25],new_notes_arr[26],new_notes_arr[27],new_notes_arr[28],new_notes_arr[29],new_notes_arr[30],new_notes_arr[31],new_notes_arr[32],new_notes_arr[33],new_notes_arr[34],new_notes_arr[35],new_notes_arr[36],new_notes_arr[37],new_notes_arr[38],new_notes_arr[39],new_notes_arr[40],new_notes_arr[41],new_notes_arr[42],new_notes_arr[43],new_notes_arr[44],new_notes_arr[45],new_notes_arr[46],new_notes_arr[47],new_notes_arr[48],new_notes_arr[49],new_notes_arr[50],new_notes_arr[51],new_notes_arr[52],new_notes_arr[53],new_notes_arr[54],new_notes_arr[55],new_notes_arr[56],new_notes_arr[57],new_notes_arr[58],new_notes_arr[59],new_notes_arr[60],new_notes_arr[61],new_notes_arr[62],new_notes_arr[63],new_notes_arr[64],new_notes_arr[65],new_notes_arr[66],new_notes_arr[67],new_notes_arr[68],new_notes_arr[69],new_notes_arr[70],new_notes_arr[71],new_notes_arr[72],new_notes_arr[73],new_notes_arr[74],new_notes_arr[75],new_notes_arr[76],new_notes_arr[77],new_notes_arr[78],new_notes_arr[79],new_notes_arr[80],new_notes_arr[81],new_notes_arr[82],new_notes_arr[83],new_notes_arr[84],new_notes_arr[85],new_notes_arr[86],new_notes_arr[87],new_notes_arr[88],new_notes_arr[89],new_notes_arr[90]] 


			#end-pad end of each field with extra space if one exists already

			# binding.pry
			# new_notes.split("\t").each do |ntseg|
				# ntseg.gsub!ntseg[78].match /\s/
			# end
			notes_extra_space = ''
			new_notes.split("\t").each do |ntseg|
				match = ntseg[78].match(/\s/) if ntseg[78]
				!!match ? notes_extra_space += ntseg + " " : notes_extra_space += ntseg
				end

			tab_count = new_notes.count("\t")
			(89-tab_count).times do
				new_notes += "\t"
			end

			csv_obj << [row[0],row[1],row[2], new_notes]

		end


	end
	# binding.pry
	File.delete "#{file}.out"
end
