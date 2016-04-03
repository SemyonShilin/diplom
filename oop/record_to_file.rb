require 'spreadsheet'
require 'matrix'

class RecordToFile

	attr_reader :file_name, :header_arr, :data_hyp, :data_cub

	def initialize(path_to_file, head, data_h, data_c)
		@file_name = path_to_file
		@header_arr = head
		@data_hyp = data_h
		@data_cub = data_c
	end

	def file_write(file_name)
		new_book = Spreadsheet::Workbook.new
		new_book.create_worksheet(:name => 'data')
		yield(new_book)
		new_book.write(file_name)
	end


  def book_write#(file_name, header_arr, average_data)
    file_write(file_name) do |new_book|

			sheet = new_book.worksheet(0)

			(data_cub.first.size).times do |r|
				(data_cub.size).times do |colum|
					sheet[r, colum] = data_cub[colum][r]
					sheet.row(r).set_format(colum, format_col(:red))
				end
			end

			(data_hyp.first.size).times do |r|
				(data_hyp.size).times do |colum|
					sheet[r, colum + data_cub.size + 1] = data_hyp[colum][r]
					sheet.row(r).set_format(colum + data_cub.size + 1, format_col(:blue))
				end
			end
    end
  end

  private

  def format_col(col)
		Spreadsheet::Format.new color: col
	end

end

class Array
  def size_mod
    self.nil? ? 0 : self.size
  end
end
