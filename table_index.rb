require 'csv'
require 'pry'


layoutfiles = Dir["../Milwaukee_Final/LAYOUT/*.*"]
table_index_hash = {}

#get base name from txt files
layoutfiles.each do |file|

  layout_file = CSV.open(file)
  filename = File.basename(file, ".TXT")
  tablename = filename.slice(0, filename=~ /_LAYOUT/)

  table_index_hash[tablename] = [] 

  layout_file.each do |row|
    field = row[0]
    datatype = row[1]
    table_index_hash[tablename] << [field, datatype]
  end
end

def insert_values(table, io)
  table[1].each do |row|
  io << "insert into \"dba\".table_index values (\"#{table[0]}\", \"#{row[0]}\", \"#{row[1]}\");\n"
  end
end

File.open("../layouts/table_index.sql", "wb") do |io|
  drop_table = "drop table 'dba'.table_index;"
  create_sql = "create table 'dba'.table_index (\ntablename char(79),\nfieldname char(79),\ndatatype char(79)\n);"
  close_sql = "commit;"

  io << drop_table + "\n\n"
  io << create_sql + "\n\n"

  table_index_hash.each do |table|
    insert_values(table, io)
  end

  io << close_sql
end


