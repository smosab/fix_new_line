require 'csv'
require 'pry'




# file = CSV.open("../TEXT.TXT", {headers: true, converters: :all, header_converters: :downcase, col_sep: '|' })
files = Dir["../TEST.TXT"] 
binding.pry
layout_file = CSV.open("../#{files.basename}_LAYOUT.txt", {headers: true, converters: :all, header_converters: :downcase, col_sep: '|' })



headers = file.readline.headers

size = {}
headers.each {|header| size[header] = 0}

datatypes = {}
headers.each {|header| datatypes[header] = ''}



file.each do |row|

  headers.each do |header|
    # binding.pry
    size[header] = row.fetch(header).inspect.size if row.fetch(header).inspect.size > size[header]
     binding.pry


    type =
    case row.fetch(header).class.inspect
    when "String"
      "char"
    when "Fixnum"
      "int"
    when "Float"
      "float"
    end


    datatypes[header] = type if datatypes[header].empty?

  end


end
