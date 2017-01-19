require 'csv'
require 'pry'


def	create_eol(linefeed, carriagereturn)
	if linefeed && carriagereturn == 'y'
		/\r\n/
	elsif linefeed == 'y' && carriagereturn == 'n'
		/\n/
	else 
		/\r/
	end
end

def create_delim(answer)
	case answer
	when 't'
		"	"
	when 'p'
		"|"
	else
		","
	end	
end


# this method will remove any double quotes between the first opening quote (|".....) and last closing quote. (....."|) from a field.
def remove_double_quotes(row)
  regex = /([^^#{Regexp.quote(@delim)}\n])(")([^#{Regexp.quote(@delim)}\n])/
  loop do
    break unless row.match(regex)
    row.gsub!(regex, '\1\3')
  end
end

def remove_blank_quoted_strings(contents)
	contents.gsub!('""','')
end

# specify the carriage return pattern to be replace here:
def remove_crlf(contents)
  contents.gsub!(/\r\n/,'')
end
	

# this method removes any delimiting characters being used to seperate fields from within each field(mainly from text/comment fields) 
def remove_delim_from_text(row)
  # binding.pry
  row.parse_csv({:col_sep => @delim }).each { |field| field.gsub!(@delim, '') unless field == nil}
end

def process_row(row)
    remove_double_quotes(row)
    remove_delim_from_text(row)
end

# def	fix_record(row)
	
	# binding.pry
# end

def fix_rows(contents)
	num_fields = contents[0..contents.index(@eol)].split(/\t/).size if HEADERS == true
	contents_arr = contents.split(@eol)
	contents_arr.shift
	fixed_row = ''
	new_contents_arr = []
	
	contents_arr.each do |row|
		row_arr = row.split(@delim)
		if	row_arr.size != num_fields
			#fix record
			fixed_row += row
			if fixed_row.split(@delim).size == 155
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


# puts "Does this file contain a header row? (y/n)"
# answer = gets.chomp.downcase
# answer == 'y' ? HEADERS = true : HEADERS = false
HEADERS = true
# puts "Does this file contain a line feed (LF) as an End of line character? (y/n)"
# linefeed = gets.chomp.downcase

# puts "Does this file contain a Carriage Return (CR) as an End of line character? (y/n)"
# carriagereturn = gets.chomp.downcase

# @eol = create_eol(linefeed, carriagereturn)
@eol = /\r\n/
# puts "How is this file delimited? (tab = t, comma = c, pipe = p)"
# @delim = create_delim(gets.chomp.downcase)
@delim = "\t"

# specify the files to be cleaned here:
csv_files = Dir["fh_party.corrected.txt"]

csv_files.each do |file|
    contents_arr = []
    File.open("#{file}", "r+b") do |f|
    contents_arr = fix_rows(f.read)
    end
	
	# fix_rows(contents)
	# remove_crlf(contents)
	# remove_blank_quoted_strings(contents)
	
    # row = process_row(row)
    # number_rows = contents.count("\n")
    # counter = 1

    CSV.open("#{file}.final", "wb",{:col_sep => @delim}) do |csv_obj| #, :force_quotes => true #,:skip_blanks => true , :quote_char => '"'
		contents_arr.each do |row|
			csv_obj << process_row(row)
		end
	end
      
end