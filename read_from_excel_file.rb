require 'spreadsheet'

class ReadFromExcelFile < Spreadsheet::Excel::Worksheet
	
	def initialize(path)
		@file_path = path
	end
	
	attr_reader :file_path
	
	def open_sheet
		Spreadsheet.open(file_path).worksheet 0
	end

	#def each
	#	0.upto(@sheet1.last_row_index) do |index|
	#		yield @sheet1.row(index)
	#	end
	#end
		
end