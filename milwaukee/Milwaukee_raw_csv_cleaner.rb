require 'csv'

#read the csv file names
csv_files = Dir["*.csv"]
	
#loop thru each csv file
csv_files.each do |file|

  #read the contents of each csv into an array
 
  csv_array = CSV.read(file)
	
  #loop thru each row
  csv_array.each do |row|
		
    #loop thru each field and replace all commas with a space
    row.each do |field|
	
    #field = " " if field == nil
    next if field == nil || field.size == 0
   
    #field.gsub!(',', ' ')
    field.gsub!(/,|\t|\\$|""/,' ')
 
    end

  end

  #output to a new file
  #CSV.open("#{file}.out", "w", {:col_sep => '	'}) do |csv_obj|
CSV.open("#{file}.out", "w",{:col_sep => '	',:skip_blanks => true})do |csv_obj|
    csv_array.each do |row|

    csv_obj << row

    end
  end

end
