require 'csv'
require 'pry'

@eol = /\n/

def remove_double_quotes(row)
  loop do
    break unless row.match /([^^|\n])(")([^|\n])/

    row.gsub!(/([^^|\n])(")([^|\n])/, '\1\3')
  end

end

def remove_delim(row)
  # binding.pry
  row.parse_csv({:col_sep => "\t" }).each { |field| field.gsub!("\t", '') unless field == nil}
end

def process(row)
    remove_double_quotes(row)
    remove_delim(row)
end

def remove_crlf(contents)
  contents.gsub!(/\r\n/,'')
end

csv_files = Dir["airgas_prod_notes_cleaned.txt"]

csv_files.each do |file|
    contents = ''
    File.open("#{file}", "r+b") do |f|
    contents = f.read
    end

    remove_crlf(contents)
    # number_rows = contents.count("\n")
    cont_arr = contents.split(@eol)


        CSV.open("#{file}.final2", "ab",{:col_sep => "\t", :quote_char => '"'}) do |csv_obj| #, :force_quotes => true #,:skip_blanks => true

      # number_rows.times do
        # binding.pry
        # row = contents[0..contents.index(@eol)] #.split(@eol)
            # binding.pry
                #.map do |row|

                  # csv_array << process(row)
                  # binding.pry
                  cont_arr.each do |row|
                  csv_obj << process(row)
                #end
        # out.syswrite(contents)
        contents.slice!(0..contents.index(@eol))

      # end
      end
    end
    # CSV.open("#{file}.final", "ab",{:col_sep => "\t", :force_quotes => true, :quote_char => '"'}) do |csv_obj|  #,:skip_blanks => true
      # csv_array.each do |row|
        # csv_obj << row
      # end
      # csv_array = []
    # end
    #out.close

    # File.delete "#{file}.out"
end