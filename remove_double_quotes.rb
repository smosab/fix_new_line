require 'csv'
require 'pry'

@eol = /\n/

def remove_double_quotes(row)
  loop do
    break unless row.match /([^^|\n])(")([^|\n])/

    row.gsub!(/([^^|\n])(")([^|\n])/, '\1\3')
  end

end

def remove_pipes(row)
  # binding.pry
  row.parse_csv({:col_sep => '|' }).each { |field| field.gsub!(/\|/, '') unless field == nil}
end

def process_row(row)

    remove_double_quotes(row)
    remove_pipes(row)
end

# specify the carriage return pattern to be replace here:
def remove_crlf(contents)
  contents.gsub!(/\r\n/,'')
end

# specify the files to be cleaned here:
csv_files = Dir["*.TXT"]

csv_files.each do |file|
    contents = ''
    File.open("#{file}", "r+b") do |f|
    #out = File.new("#{f.path}.out", "w+b")
    # csv_array = []
    contents = f.read
    end

    remove_crlf(contents)
    # row = process_row(row)
    number_rows = contents.count("\n")
    # counter = 1




        CSV.open("#{file}.final", "ab",{:col_sep => '|', :quote_char => '"'}) do |csv_obj| #, :force_quotes => true #,:skip_blanks => true

      number_rows.times do
        # binding.pry
        row = contents[0..contents.index(@eol)] #.split(@eol)
            # binding.pry
                #.map do |row|

                  # csv_array << process_row(row)
                  # binding.pry
                  csv_obj << process_row(row)
                #end
        # out.syswrite(contents)
        contents.slice!(0..contents.index(@eol))

      # end
      end
    end
    # CSV.open("#{file}.final", "ab",{:col_sep => '|', :force_quotes => true, :quote_char => '"'}) do |csv_obj|  #,:skip_blanks => true
      # csv_array.each do |row|
        # csv_obj << row
      # end
      # csv_array = []
    # end
    #out.close

    # File.delete "#{file}.out"
end