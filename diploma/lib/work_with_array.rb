require 'mathn'

class WorkWithArray

	attr_accessor :array_from_sheet, :array_head, :array_average, :hash_from_array

	def initialize(array_from_sheet)
		@array_from_sheet = array_from_sheet
		@array_head, @array_average = [], []
		@hash_from_array = {}
	end

	def header
		array_from_sheet.each do |elem|
			elem[0].class == String ? @array_head << elem : break
			#array_from_sheet.shift
		end
		(array_head.size).times {|i| array_from_sheet.shift}
		array_head
	end

	def sort_array!
		array_from_sheet.sort_by!{|line| line[0]}
		#array_from_sheet.each{|elem| print "#{elem}\n"}
	end

	def average!
		y, vec = 1, Vector[*array_from_sheet.at(0)]
		(array_from_sheet.size-1).times do |index|
			if array_from_sheet[index][0] == array_from_sheet[index + 1][0]
				vec += Vector[*array_from_sheet[index+1]]
				y += 1
			else
				@array_average << vec/y
				vec, y = Vector[*array_from_sheet.at(index + 1)], 1
				next
			end
		end

		@array_average << vec/y
		@array_average.map!{|elem| elem.to_a}#.each{|elem| print "#{elem} \n"}
	end

	def array_to_hash
		0.upto(array_head.last.to_a.size - 1) do |index|
			@hash_from_array[array_head[1][index]] = array_average.transpose[index]
		end
		hash_from_array
	end

end
