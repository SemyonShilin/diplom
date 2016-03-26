path = File.expand_path(" . ")
require 'gtk3'
require "#{path}\\read_from_excel_file"
require "#{path}\\work_with_array"
require "#{path}\\record_to_file"
require "#{path}\\mnk_cubic_parabola"
require "#{path}\\mnk_hyperbola"
require "#{path}\\plot_cubic_parabola"
require "#{path}\\plot_hyperbola"

adv = []
puts 'Введите путь и имя файла (Пример: C:\\Excel.xls)'
#file_name_1 = gets.chomp.capitalize
puts file_name_1 = 'C:\\Excel.xls'
file = ReadFromExcelFile.new(file_name_1).open_sheet.each{|row| adv<<row}

array = WorkWithArray.new(adv)

head_data = array.header
array.sort_array!
average_data = array.average

puts 'Введите путь и имя файла (Пример: C:\\Average data.xls)'
#file_name_2 = gets.chomp.capitalize
puts file_name_2 = 'C:\\Average data.xls'

write_file = RecordToFile.new(file_name_2, head_data, average_data)
#record to file. передать сюда объект ReadFromExcelFile
write_file.book_write#(file_name_2, head_data, average_data)

row_data_with_id = array.array_to_hash

puts 'Выберете ген:'
head_data.last.each{|elem| print "#{elem} " if elem[/CG/]}
gene = gets.chomp!.upcase!
#p row_data_with_id[gene]

cubic_parabola_equation = CubicParabola.new(row_data_with_id["Calibration ID"],
																						 row_data_with_id[gene])

plot = PlotCP.new(cubic_parabola_equation)
plot.ploting_equation

hyperbola_equation = Hyperbola.new(row_data_with_id["Calibration ID"],
																		row_data_with_id[gene])

plot = PlotHyp.new(hyperbola_equation)
plot.ploting_equation
