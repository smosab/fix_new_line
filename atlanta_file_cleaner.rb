require 'csv'

@eol = /\n/
@delim = /\t/

# this method will remove any double quotes between the first opening quote (|".....) and last closing quote. (....."|) from a field.
def remove_double_quotes(row)
  loop do
    break unless row.match /([^^|\n])(")([^|\n])/
    row.gsub!(/([^^|\n])(")([^|\n])/, '\1\3')
  end

end

def remove_blank_quoted_strings(contents)
  contents.gsub!('""','')
end

# specify the carriage return pattern to be replace here:
def remove_lf(contents)
  regexp = /\n(?:(?!SI0973))/
  loop do
    break unless !!contents.match(regexp)
      contents.gsub!(regexp,'')
  end
end
	
# this method removes any delimiting characters being used to seperate fields from within each field(mainly from text/comment fields) 
def remove_delim(row, delimiter)
  row.parse_csv({:col_sep => delimiter }).each { |field| field.gsub!(delimiter, '') unless field == nil}
end

def process(row)
    remove_double_quotes(row)
    remove_blank_quoted_strings(row)
    remove_delim(row, @delim)
    row
end

# specify the files to be cleaned here:
csv_files = Dir["lossrun_test.txt"]

csv_files.each do |file|
  contents = ''

  File.open("#{file}", "r+b") do |f|
    puts "Reading contents..."
    contents = f.read
  end
	
  puts "Removing non-endofline line-feed characters..."
	remove_lf(contents)
  number_rows = contents.count("\n")  

  puts "Creating fnal file..."
  CSV.open("#{file}.final", "wb",{:col_sep => "\t"}) do |csv_obj| 

    contents.split(@eol).each do |row|
      row = process(row).split(@delim).map { |f| f == "" ? nil : f }
      csv_obj << row
    end
  end
end