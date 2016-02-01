path = File.expand_path(" . ")
require 'gtk3'
require "#{path}\\read_from_excel_file"
require "#{path}\\work_with_array"
require "#{path}\\record_to_file"
require "#{path}\\mnk_cubic_parabola"
require "#{path}\\plot_cubic_parabola"

adv = []
puts 'Введите путь и имя файла (Пример: C:\\Excel.xls)'
#file_name_1 = gets.chomp.capitalize
puts file_name_1 = 'C:\\Excel.xls'
file = ReadFromExcelFile.new(file_name_1).open_sheet.each{|row| adv<<row}

array = WorkWithArray.new(adv)

head_data = array.header
sort_data = array.sort_array!
average_data = array.average

puts 'Введите путь и имя файла (Пример: C:\\Average data.xls)'
#file_name_2 = gets.chomp.capitalize
puts file_name_2 = 'C:\\Average data.xls'

write_file = RecordToFile.new
#record to file. передать сюда объект ReadFromExcelFile
write_file.book_wr(file_name_2, head_data, average_data)

row_data_with_id = array.array_to_hash

puts 'Выберете ген:'
head_data.last.each{|elem| print "#{elem} " if elem[/CG/]}
gene = gets.chomp!.upcase!
#p row_data_with_id[gene]
cubic_parabola_equation = CubicParabola.new(row_data_with_id["Calibration ID"],
																						row_data_with_id[gene])
			
# p cubic_parabola_equation.sum(cubic_parabola_equation.x)
# p cubic_parabola_equation.sum(cubic_parabola_equation.y)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_square)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_cubic)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_fourth)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_fifth)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_sixth)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_on_y)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_square_on_y)
# p cubic_parabola_equation.sum(cubic_parabola_equation.x_cubic_on_y)
# p cubic_parabola_equation.general_determinant
# p cubic_parabola_equation.determinant_a
# p cubic_parabola_equation.determinant_b
# p cubic_parabola_equation.determinant_c
# p cubic_parabola_equation.determinant_d	
# p cubic_parabola_equation.coefficient_a
# p cubic_parabola_equation.coefficient_b
# p cubic_parabola_equation.coefficient_c
# p cubic_parabola_equation.coefficient_d
plot = PlotCP.new(cubic_parabola_equation)
plot.ploting_equation																			
