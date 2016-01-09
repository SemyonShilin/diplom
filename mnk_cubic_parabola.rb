require 'mathn'
require 'matrix'

class CubicParabola
	
	def initialize (id, gene)
		@x, @y = id, gene
	end
	
	attr_accessor :x, :y
	
	def sum(array)
		array.inject(0){|result, elem| result + elem}
	end
	
	def x_square
		x.map{|x_i| x_i**2}
	end
	
	def x_cubic
		x.map{|x_i| x_i**3}
	end
	
	def x_fourth
		x.map{|x_i| x_i**4}
	end
	
	def x_fifth
		x.map{|x_i| x_i**5}
	end
	
	def x_sixth
		x.map{|x_i| x_i**6}
	end

	def x_on_y
		temp = []
		(x.size).times do |index|
			temp << x[index]*y[index]
		end
		temp
	end
	
	def x_square_on_y
		temp = []
		(x.size).times do |index|
			temp << x_square[index]*y[index]
		end
		temp
	end
	
	def x_cubic_on_y
		temp = []
		(x.size).times do |index|
			temp << x_cubic[index]*y[index]
		end
		temp
	end	
	
	def general_determinant
		Matrix[[sum(x_cubic), sum(x_square), sum(x), x.size],
					 [sum(x_fourth), sum(x_cubic), sum(x_square), sum(x)],
					 [sum(x_fifth), sum(x_fourth), sum(x_cubic), sum(x_square)],
					 [sum(x_sixth), sum(x_fifth), sum(x_fourth), sum(x_cubic)]
					].det
	end
	
	def determinant_a
		Matrix[[sum(y), sum(x_square), sum(x), x.size],
					 [sum(x_on_y), sum(x_cubic), sum(x_square), sum(x)],
					 [sum(x_square_on_y), sum(x_fourth), sum(x_cubic), sum(x_square)],
					 [sum(x_cubic_on_y), sum(x_fifth), sum(x_fourth), sum(x_cubic)]
					].det
	end
	
	def determinant_b
		Matrix[[sum(x_cubic), sum(y), sum(x), x.size],
					 [sum(x_fourth), sum(x_on_y), sum(x_square), sum(x)],
					 [sum(x_fifth), sum(x_square_on_y), sum(x_cubic), sum(x_square)],
					 [sum(x_sixth), sum(x_cubic_on_y), sum(x_fourth), sum(x_cubic)]
					].det
	end
	
	def determinant_c
		Matrix[[sum(x_cubic), sum(x_square), sum(y), x.size],
					 [sum(x_fourth), sum(x_cubic), sum(x_on_y), sum(x)],
					 [sum(x_fifth), sum(x_fourth), sum(x_square_on_y), sum(x_square)],
					 [sum(x_sixth), sum(x_fifth), sum(x_cubic_on_y), sum(x_cubic)]
					].det
	end
	
	def determinant_d
		Matrix[[sum(x_cubic), sum(x_square), sum(x), sum(y)],
					 [sum(x_fourth), sum(x_cubic), sum(x_square), sum(x_on_y)],
					 [sum(x_fifth), sum(x_fourth), sum(x_cubic), sum(x_square_on_y)],
					 [sum(x_sixth), sum(x_fifth), sum(x_fourth), sum(x_cubic_on_y)]
					].det
	end
	
	def coefficient_a
		determinant_a/general_determinant
	end
	
	def coefficient_b
		determinant_b/general_determinant
	end
	
	def coefficient_c
		determinant_c/general_determinant
	end
	
	def coefficient_d
		determinant_d/general_determinant
	end
	
end