require 'csv'
require 'pry'

client = "milwaukee"
source = "ventiv"

def processfield(fieldname)
    fieldname.gsub!(/[[:punct:]]/, '')
    fieldname.gsub!(/[[:blank:]]/, '')
    fieldname.gsub!('_', '')

    if fieldname.length > 18
      # binding.pry
      fieldname = fieldname[0] + fieldname[1..fieldname.length].gsub!(/[aeiou]/, "")
    elsif fieldname.length > 18 
      fieldname.slice!(0,18)
    else fieldname
    end
  end

  def processtable(table)
    table.gsub!(/[[:punct:]]/, '')
    table.gsub!(/[[:blank:]]/, '')
    table.gsub!('_', '')

    if table.length > 18
      # binding.pry
      table = table[0] + table[1..table.length].gsub!(/[aeiou]/, "")
    elsif table.length > 18 
      table.slice!(0,18)
    else table
    end
  end

  def get_char_size(datatype)
    
    char_size = datatype.match(/\([0-9]+\)/) ? datatype.match(/\(([0-9]+)\)/).captures[0].to_i : 79

    if char_size.to_i > 79
      "79"
    else
      "#{char_size.to_i}"
    end
  end

  def processtype(datatype, fieldname)
    
    if fieldname.include?("amount")
      "decimal(13,2)"
    elsif datatype.include?("date")
      #"date"
      #just for milwaukee conversion
      "varchar(19)"
    else "varchar(#{get_char_size(datatype)})"
    end 
  end

# layoutfiles = Dir["../Milwaukee_Final/LAYOUT/*_LAYOUT.TXT"]
layoutfiles = Dir["../Milwaukee_Final/LAYOUT/PAYMENT_CHECK_LAYOUT.TXT"]

#get base name from txt files
layoutfiles.each do |file|

  
  # layout_file = CSV.open("../#{basename}_LAYOUT.txt")

  layout_file = CSV.open(file)
  basename = File.basename(file, ".TXT").downcase
  basename_shortened = processtable(basename.slice(0, basename=~ /_layout/))
  base_name_data = basename.gsub("_layout", "_data")
 

  field_type_hash = {}

  layout_file.each do |row|
    field = row[0].downcase
    datatype = row[1].downcase
    datatype = processtype(datatype, field)
    fieldname = processfield(field)

    field_type_hash[fieldname] = datatype
  end

  File.open("../layouts/#{basename}_load.sql", "wb") do |io|
    drop_table = "drop table 'dba'.#{basename_shortened};"
    opening_sql = "create table 'dba'.#{basename_shortened} (\n"
    body_sql = ''
    field_type_hash.each do |v,k| 
    body_sql << "  #{v} #{k},\n"
    end
    close_sql = ")\nextent size 1024 next size 1024\nlock mode page;"

    insert_steatement = "load from '/raw/gb/#{source}/#{client}/final_raw/#{base_name_data}.txt.final' delimiter '|' insert into 'dba'.#{basename_shortened};\ncommit;"
    
    io << drop_table + "\n\n"
    io << opening_sql
    io << body_sql.gsub!(/,\n$/,"\n")
    io << close_sql + "\n\n"
    io << insert_steatement
  end

end
