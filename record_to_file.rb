require 'spreadsheet'

class RecordToFile

	def initialize(path_to_file, head, data)
		@file_name = path_to_file
		@header_arr = head
		@average_data = data
	end
	
	attr_reader :file_name, :header_arr, :average_data

	def file_write(file_name)
		new_book = Spreadsheet::Workbook.new
		new_book.create_worksheet(:name => 'average data')
		yield(new_book)
		new_book.write(file_name)
	end


  def book_write#(file_name, header_arr, average_data)
    file_write(file_name) do |new_book|
			0.upto(header_arr.size-1) do |index|
				new_book.worksheet(0).insert_row(index, header_arr[index])
			end
			0.upto(average_data.size-1) do |index|
				new_book.worksheet(0).insert_row(index+2, average_data[index])
			end
    end
  end

end