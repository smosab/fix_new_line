require 'csv'
require 'pry'


csv_files = Dir["*clm.txt"]

csv_files.each do |file|
	contents = ''
	File.open("#{file}", "r+b") {|f| contents = f.read}

						# new_claims = []

						contents.slice!(0,2002)

						loop do
							CSV.open("#{file}.tab", "ab",{:col_sep => "\t"}) do |csv_obj|  
								csv_obj << [contents.slice!(0,30),contents.slice!(0,2),
									contents.slice!(0,1),contents.slice!(0,10),contents.slice!(0,1),
									contents.slice!(0,18),contents.slice!(0,13),contents.slice!(0,1),
									contents.slice!(0,1),contents.slice!(0,8),contents.slice!(0,8),
									contents.slice!(0,8),contents.slice!(0,5),contents.slice!(0,2),
									contents.slice!(0,3),contents.slice!(0,2),contents.slice!(0,3),
									contents.slice!(0,8),contents.slice!(0,8),contents.slice!(0,8),
									contents.slice!(0,4),contents.slice!(0,4),contents.slice!(0,4),
									contents.slice!(0,4),contents.slice!(0,4),contents.slice!(0,4),
									contents.slice!(0,2),contents.slice!(0,2),contents.slice!(0,2),
									contents.slice!(0,4),contents.slice!(0,1),contents.slice!(0,1),
									contents.slice!(0,1),contents.slice!(0,1),contents.slice!(0,1),
									contents.slice!(0,1),contents.slice!(0,1),contents.slice!(0,1),
									contents.slice!(0,19),contents.slice!(0,19),contents.slice!(0,19),
									contents.slice!(0,19),contents.slice!(0,19),contents.slice!(0,19),
									contents.slice!(0,19),contents.slice!(0,19),contents.slice!(0,19),
									contents.slice!(0,19),contents.slice!(0,19),contents.slice!(0,19),
									contents.slice!(0,30),contents.slice!(0,30),contents.slice!(0,22),
									contents.slice!(0,2),contents.slice!(0,3),contents.slice!(0,5),
									contents.slice!(0,4),contents.slice!(0,1),contents.slice!(0,3),
									contents.slice!(0,11),contents.slice!(0,20),contents.slice!(0,8),
									contents.slice!(0,2),contents.slice!(0,8),contents.slice!(0,8),
									contents.slice!(0,8),contents.slice!(0,3),contents.slice!(0,8),
									contents.slice!(0,8),contents.slice!(0,8),contents.slice!(0,1),
									contents.slice!(0,4),contents.slice!(0,5),contents.slice!(0,5),
									contents.slice!(0,6),contents.slice!(0,4),contents.slice!(0,66),
									contents.slice!(0,66),contents.slice!(0,18),contents.slice!(0,15),
									contents.slice!(0,22),contents.slice!(0,18),contents.slice!(0,13),
									contents.slice!(0,30),contents.slice!(0,30),contents.slice!(0,22),
									contents.slice!(0,2),contents.slice!(0,3),contents.slice!(0,5),
									contents.slice!(0,4),contents.slice!(0,11),contents.slice!(0,2),
									contents.slice!(0,1),contents.slice!(0,1),contents.slice!(0,17),
									contents.slice!(0,4),contents.slice!(0,30),contents.slice!(0,19),
									contents.slice!(0,19),contents.slice!(0,19),contents.slice!(0,19),
									contents.slice!(0,19),contents.slice!(0,19),contents.slice!(0,25),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,8),
									contents.slice!(0,8),contents.slice!(0,8),contents.slice!(0,1),
									contents.slice!(0,1),contents.slice!(0,8),contents.slice!(0,1),
									contents.slice!(0,1),contents.slice!(0,7),contents.slice!(0,11),
									contents.slice!(0,31),contents.slice!(0,30),contents.slice!(0,30),
									contents.slice!(0,22),contents.slice!(0,2),contents.slice!(0,20),
									contents.slice!(0,3),contents.slice!(0,6),contents.slice!(0,4),
									contents.slice!(0,1),contents.slice!(0,20),contents.slice!(0,50),
									contents.slice!(0,31),contents.slice!(0,31),contents.slice!(0,25),
									contents.slice!(0,20),contents.slice!(0,2),contents.slice!(0,3),
									contents.slice!(0,1),contents.slice!(0,30),contents.slice!(0,40),
									contents.slice!(0,40),contents.slice!(0,20),contents.slice!(0,30),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,10),contents.slice!(0,10),
									contents.slice!(0,10),contents.slice!(0,1),contents.slice!(0,8),
									contents.slice!(0,1),contents.slice!(0,28)]
							end
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,18)
							# new_claims << contents.slice!(0,13)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,5)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,22)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,5)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,11)
							# new_claims << contents.slice!(0,20)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,5)
							# new_claims << contents.slice!(0,5)
							# new_claims << contents.slice!(0,6)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,66)
							# new_claims << contents.slice!(0,66)
							# new_claims << contents.slice!(0,18)
							# new_claims << contents.slice!(0,15)
							# new_claims << contents.slice!(0,22)
							# new_claims << contents.slice!(0,18)
							# new_claims << contents.slice!(0,13)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,22)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,5)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,11)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,17)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,19)
							# new_claims << contents.slice!(0,25)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,7)
							# new_claims << contents.slice!(0,11)
							# new_claims << contents.slice!(0,31)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,22)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,20)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,6)
							# new_claims << contents.slice!(0,4)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,20)
							# new_claims << contents.slice!(0,50)
							# new_claims << contents.slice!(0,31)
							# new_claims << contents.slice!(0,31)
							# new_claims << contents.slice!(0,25)
							# new_claims << contents.slice!(0,20)
							# new_claims << contents.slice!(0,2)
							# new_claims << contents.slice!(0,3)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,40)
							# new_claims << contents.slice!(0,40)
							# new_claims << contents.slice!(0,20)
							# new_claims << contents.slice!(0,30)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,10)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,8)
							# new_claims << contents.slice!(0,1)
							# new_claims << contents.slice!(0,28)
							contents.slice!(0,2)
							# binding.pry

						# CSV.open("#{file}.tab", "ab",{:col_sep => "\t"}) do |csv_obj|  
						# 	csv_obj << new_claims
						# end
						# new_claims = []

						break if contents.empty?
						end
	end

