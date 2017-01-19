require 'csv'
require 'pry'

#Set parameters here:

HEADERS = true
@eol = /\n/ #End of line character
@delim = "|" #File delimiter
@number_of_fields = 23 #Thi is the number of columns in the file. Should be a fixed number.
csv_files = Dir["*_DATA.txt"] #File extension


# this method will remove extra double quotes
def remove_double_quotes(row)
  regex = /([^^#{Regexp.quote(@delim)}\n])(")([^#{Regexp.quote(@delim)}\n])/
  # row.split(@delim).each { |field| field.gsub!(regex, '\1\3') unless field == nil}

  loop do
    break unless row.match(regex)
    row.gsub!(regex, '\1\3')
  end
  row
end

	
# this method removes any delimiting characters being used to seperate fields from within each field(mainly from text/comment fields) 
def remove_delim_from_text(row)
  row.parse_csv({:col_sep => @delim }).each { |field| field.gsub!(@delim, '') unless field == nil}.join(@delim)
end

def process(row)
    row = remove_double_quotes(row)
    row = remove_delim_from_text(row)
end

def fix_rows(contents)
	# @number_of_fields = contents[0..contents.index(@eol)].split(@delim).size
	contents_arr = contents.split(@eol)
	contents_arr.shift if HEADERS == true
	
	fixed_row = ''
	new_contents_arr = []
	
	contents_arr.each do |row|
		row = process(row)
		row_arr = process(row).split(@delim)
					 
		if	row_arr.size != @number_of_fields
			#fix record
			fixed_row += row
			if fixed_row.split(@delim).size == @number_of_fields

				new_contents_arr << fixed_row 

				fixed_row = ''
			end
		else
			#add valid row to new array and go to next array element (row)
			new_contents_arr << row
			next
		end
	end
	new_contents_arr
	
end

csv_files.each do |file|
    contents_arr = []
    File.open("#{file}", "rb") do |f|
    contents_arr = fix_rows(f.read)
    end

    CSV.open("#{file}.final", "wb",{:col_sep => @delim, :headers => true}) do |csv_obj| #, :force_quotes => true #,:skip_blanks => true , :quote_char => '"', :converters => "all"
		contents_arr.each do |row|
			csv_obj << row.parse_csv({:col_sep => @delim })
		end
	end
      
end