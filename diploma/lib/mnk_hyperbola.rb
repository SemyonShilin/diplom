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

	def coefficient_d
		(-b - Math.sqrt(deskr))/(2 * a)
	end

	def coefficient_a
		(y.last * (x.last + coefficient_d) - y.first * coefficient_d)/x.last
	end

	def coefficient_b
		y.first * coefficient_d
	end

	private

  def a
  	(x.last * y.first - x.last * y.first * sum(y_in_degree_n(1)) - x.last * y.last) * sum(x_in_degree_n(1)) +
  	(x.last**2) * y.first * sum(y_in_degree_n(1)) + x.last * y.first * sum(x_in_degree_n_on_y(1))
  end

  def b
  	sum(x_in_degree_n) * (x.last * y.last - x.last * y.first) * (sum(y_in_degree_n(1)) - 1) +
  	2* (x.last**2) * y.first * sum(x_in_degree_n_on_y) - (x.last**2) * y.first * sum(x_in_degree_n(1)) +
  	(x.last**2) * y.first * x.size - (y.last**2 - y.first * y.last + y.last**2) * sum(x_in_degree_n(3)) +
  	(y.first * y.last - 3 * x.last * y.first * y.last + x.last * y.last**2 + 2 * x.last * y.first**2) * sum(x_in_degree_n(2)) -
  	((x.last**2) * y.first**2 - (x.last**2) * y.first * y.last) * sum(x_in_degree_n(1))
  end

  def c
  	x.last * (y.last-y.first) * sum(x_in_degree_n_on_y(3)) + (x.last**2) * y.first * sum(x_in_degree_n_on_y(2)) +
  	(x.last**2) * y.first * x.size * sum(x_in_degree_n(1)) - x.last * y.first * sum(x_in_degree_n)
  end

	def deskr
		(b**2) - 4 * a * c
	end

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
end
