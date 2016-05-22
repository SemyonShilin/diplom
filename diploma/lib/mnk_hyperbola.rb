require 'mathn'
require 'matrix'
require_relative 'methods'
#path = File.expand_path("../../lib", __FILE__)
#require "#{path}/methods"

class Hyperbola

	include Methods

	attr_reader :x, :y, :full_x, :full_y

	def initialize (id, gene)
		@full_x = id
		@full_y = gene
		@x, @y = id, gene #id[1..-2], gene[1..-2]
	end

	# def coefficient_a
		# (full_y.last * full_x.last + (full_y.last - full_y.first) * coefficient_d)/full_x.last
	# end

	# def coefficient_b
		# full_y.first * coefficient_d
	# end

	# def coefficient_d
		 # ((full_x.last**2) * (full_y.last**2) * sum(y_in_divisible_by_x(2)))/
			 # (((full_y.last - full_y.first) * sum(y_in_divisible_by_x(1)) + full_x.last * full_y.first) *
				# ((full_y.last + full_x.last * full_y.last) * sum(y_in_divisible_by_x(2)) + full_x.last * sum(y_in_divisible_by_x(2, 1)) +
					 # (full_x.last * (full_y.first - full_y.last) - full_y.first) * sum(y_in_divisible_by_x(1)) + full_x.last * sum(y_in_divisible_by_x(1, 1))
				# )
			# )
  # end

  #способ через кв уравнение, выражал через х0 и х100 а, б и д


	#def koren1
		#(-b + Math.sqrt(deskr))/(2*a)
	#end

	# def coefficient_d
	# 	(-b - Math.sqrt(deskr))/(2 * a)
	# end
  #
	# def coefficient_a
	# 	(y.last * (x.last + coefficient_d) - y.first * coefficient_d)/x.last
	# end
  #
	# def coefficient_b
	# 	y.first * coefficient_d
	# end

	# через бинарный поиск

	# def coefficient_a
	# 	x.last*y.last + (y.last - y.first)*coefficient_d
	# end
  #
	# def coefficient_b
	# 	y.first*coefficient_d
	# end
  #
	# def coefficient_d
	# 	# array_for_d.bsearch do |d|
	# 	# 	(sum(y) - (x.last*y.last*sum(x) + ((y.last-y.first)*sum(x) + y.first*x.first)*d)/(sum(x)+d*x.size))*
	# 	# 	(((y.last-y.first)*sum(x) + y.first*x.first)*(sum(x)+d) - (x.last*y.last*sum(x) + ((y.last-y.first)*sum(x) + y.first*x.first)*d))/
	# 	# 			(sum(x) + d)**2
	# 	# end
	# end
  #
	# def range_zero
	# 	temp = []
	# 	array_for_d.each do |d|
	# 		rrr = ((y.last-y.first)*sum(x_in_degree_n) + x.last*y.first*sum(x_in_degree_n(1)) + (y.last-y.first)*sum(x_in_degree_n(1))*d + 2*x.last*y.first*d*x.size -
	# 			x.last*y.last*sum(x_in_degree_n(1)) + (y.last-y.first)*sum(x_in_degree_n) + x.last*y.first*sum(x_in_degree_n(1)) + (y.last-y.first)*d*sum(x_in_degree_n(1)) + x.last*y.first*d*x.size)/(sum(x_in_degree_n)+2*sum(x_in_degree_n(1))*d + x.size*d**2)
	# 		if rrr == 0
	# 			temp << d
	# 		end
	# 	end
	# 	 temp
  #
	# end


	# через замену. линейная множественная регрессия
	def coefficient_a
		# determinant_k1/general_determinant
		(x.last*y.last + (y.last-y.first)*coefficient_d)/x.last
	end

	def coefficient_b
		# determinant_k3/general_determinant
		y.first*coefficient_d
	end

	def coefficient_d
		-(determinant_k2/general_determinant)
	end

	private

	# через квадратное уравнение
  # def a
  	# (x.last * y.first - x.last * y.first * sum(y_in_degree_n(1)) - x.last * y.last) * sum(x_in_degree_n(1)) +
  	# (x.last**2) * y.first * sum(y_in_degree_n(1)) + x.last * y.first * sum(x_in_degree_n_on_y(1))
  # end
  #
  # def b
  	# sum(x_in_degree_n) * (x.last * y.last - x.last * y.first) * (sum(y_in_degree_n(1)) - 1) +
  	# 2* (x.last**2) * y.first * sum(x_in_degree_n_on_y) - (x.last**2) * y.first * sum(x_in_degree_n(1)) +
  	# (x.last**2) * y.first * x.size - (y.last**2 - y.first * y.last + y.last**2) * sum(x_in_degree_n(3)) +
  	# (y.first * y.last - 3 * x.last * y.first * y.last + x.last * y.last**2 + 2 * x.last * y.first**2) * sum(x_in_degree_n(2)) -
  	# ((x.last**2) * y.first**2 - (x.last**2) * y.first * y.last) * sum(x_in_degree_n(1))
  # end
  #
  # def c
  	# x.last * (y.last-y.first) * sum(x_in_degree_n_on_y(3)) + (x.last**2) * y.first * sum(x_in_degree_n_on_y(2)) +
  	# (x.last**2) * y.first * x.size * sum(x_in_degree_n(1)) - x.last * y.first * sum(x_in_degree_n)
  # end
  #
	# def deskr
	# 	(b**2) - 4 * a * c
	# end

	#матричный способ
	# def general_determinant
		# Matrix[[x.size, sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(1))],
					 # [sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(2, 2)), sum(y_in_divisible_by_x(2, 1))],
					 # [sum(y_in_divisible_by_x(1)), sum(y_in_divisible_by_x(2, 1)), sum(y_in_divisible_by_x(2))]
					# ].det
	# end

	# def determinant_a
		# Matrix[[sum(y), sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(1))],
					 # [sum(y_in_divisible_by_x(1, 2)), sum(y_in_divisible_by_x(2, 2)), sum(y_in_divisible_by_x(2, 1))],
					 # [sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(2, 1)), sum(y_in_divisible_by_x(2))]
					# ].det
	# end

	# def determinant_b
		# Matrix[[x.size, sum(y_in_divisible_by_x(1, 1)), sum(y)],
					 # [sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(2, 2)), sum(y_in_divisible_by_x(1, 2))],
					 # [sum(y_in_divisible_by_x(1)), sum(y_in_divisible_by_x(2, 1)), sum(y_in_divisible_by_x(1, 1))]
					# ].det
	# end

	# def determinant_d
		# Matrix[[x.size, sum(y), sum(y_in_divisible_by_x(1))],
					 # [sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(1, 2)), sum(y_in_divisible_by_x(2, 1))],
					 # [sum(y_in_divisible_by_x(1)), sum(y_in_divisible_by_x(1, 1)), sum(y_in_divisible_by_x(2))]
					# ].det
	# end

	# def coefficient_a
		# determinant_a/general_determinant
	# end

	# def coefficient_b
		# determinant_b/general_determinant
	# end

	# def coefficient_d
		# -determinant_d/general_determinant
	# end

	#через бинарный поиск
	# def array_for_d
	# 	temp = []
	# 	(-0.00000001).step(by: 0.00000001, to: 300){|elem| temp << elem}
	# 	temp
	# end

	# через замену. линейная множественная регрессия

	def general_determinant
		Matrix[[sum(x_in_degree_n), sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y)],
					 [sum(x_in_degree_n_on_y), sum(y_in_degree_n(1)), sum(y_in_degree_n)],
					 [sum(x_in_degree_n(1)), sum(y_in_degree_n(1)), x.size]
					].det
	end

	def determinant_k1
		Matrix[[sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y)],
					 [sum(mult(x_in_degree_n_on_y, y_in_degree_n(1))), sum(y_in_degree_n(1)), sum(y_in_degree_n)],
					 [sum(x_in_degree_n_on_y), sum(y_in_degree_n(1)), x.size]
					].det
	end

	def determinant_k2
		Matrix[[sum(x_in_degree_n), sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n_on_y)],
					 [sum(x_in_degree_n_on_y), sum(mult(x_in_degree_n_on_y, y_in_degree_n(1))), sum(y_in_degree_n)],
					 [sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y), x.size]
		].det
	end

	def determinant_k3
		Matrix[[sum(x_in_degree_n), sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y(2))],
					 [sum(x_in_degree_n_on_y), sum(y_in_degree_n(1)), sum(mult(x_in_degree_n_on_y, y_in_degree_n(1)))],
					 [sum(x_in_degree_n(1)), sum(y_in_degree_n(1)), sum(x_in_degree_n_on_y)]
		].det
	end
end
