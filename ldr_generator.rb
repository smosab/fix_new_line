require 'csv'
require 'pry'

client = "milwaukee"
source = "ventiv"
path = File.expand_path(__FILE__)
# FILES = %w(CLAIMANT_BODY_PART
# COMMUTATION_DETAIL
# COMPENSATION_RATE
# CMS_CLAIM_REPORT
# DRIVER_TYPE
# EMPLOYEE
# EMPLOYMENT
# LITIGATION
# LITIGATION_VENDOR
# NATURE_OF_INJURY
# OCCUPATION
# PAYEE
# PAYMENT_TRANSACTION
# POLICY_PERIOD
# VENDOR
# WORK_COMP_CLAIMANT
# NOTEPAD)

FILES = %w(PAYMENT_TRANSACTION)

def processfield(fieldname)
  fieldname.gsub!(/[[:punct:]]/, '')
  fieldname.gsub!(/[[:blank:]]/, '')
  fieldname.gsub!('_', '')

  if fieldname.length > 18
  # binding.pry
    fieldname = fieldname[0] + fieldname[1..fieldname.length].gsub!(/[aeiou]/, "")
  else 
    fieldname
  end

  if fieldname.length > 18 
    #ask user how to proceed
    user_entry  = ''
    loop do
      puts "'#{fieldname}' is still longer than 18. Please enter a field name is shorter: "
      user_entry = gets.chomp
      break if user_entry.length <= 18
    end
    fieldname = user_entry
  end
fieldname
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

def get_length(datatype)
  if datatype.match /char/
  # char_size = datatype.match(/\([0-9]+\)/) ? datatype.match(/\(([0-9]+)\)/).captures[0].to_i : 79
    char_size = datatype.match(/\(([0-9]+)\)/).captures[0].to_i
    char_size > 79 ? "79" : char_size
  elsif datatype.match /number/
    "13"
  else
    "19"
  end
end

def processtype(datatype, fieldname)
  if fieldname.include?("amount")
    "NUMBER"
  elsif datatype.include?("date")
    "DATE"
  else "STRING"
  end 
end

def get_modifier(datatype)
  case datatype
  when "DATE"
    "MM/DD/YYYY"
  when "NUMBER"
   "2"
  when "STRING"
    "TRIM UPPERCASE"
  end
end


layoutfiles = []

FILES.each do |file|
  layoutfiles << Dir["C:/Users/msasi/Desktop/Milwaukee_Final/LAYOUT/#{file}_LAYOUT.TXT"].first
end

#get base name from txt files
layoutfiles.each do |file|

  # layout_file = CSV.open("../#{basename}_LAYOUT.txt")

  layout_file = CSV.open(file)
  basename = File.basename(file, ".TXT").downcase
  basename_shortened = processtable(basename.slice(0, basename=~ /_layout/))
  base_name_data = basename.gsub("_layout", "_data")
  
  loader_fields = {}

  layout_file.each_with_index do |row, rowid|
    field = row[0].downcase
    datatype = row[1].downcase
    max_length = get_length(datatype)   
    datatype = processtype(datatype, field)
    modifier = get_modifier(datatype)
    fieldname = processfield(field)

    start_position = rowid + 1
      
    loader_fields[fieldname] = [fieldname.upcase, datatype, start_position, max_length, modifier]

  end


  CSV.open("C:/Users/msasi/Desktop/layouts/#{basename}.csv", "ab") do |csv_obj|
    loader_fields.each do |fld, att|
      
      csv_obj << att
    end
  end

end
