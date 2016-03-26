require 'mathn'
require 'matrix'
path = File.expand_path(" . ")
require "#{path}\\methods"

class Hyperbola

	include Methods

	def initialize (id, gene)
		@full_x = id
		@full_y = gene
		@x, @y = id[1..-2], gene[1..-2]
	end

	attr_reader :x, :y, :full_x, :full_y

	def coefficient_a
		(full_y.last * full_x.last + (full_y.last - full_y.first) * coefficient_d)/full_x.last
	end

	def coefficient_b
		full_y.first * coefficient_d
	end

	def coefficient_d
		 (full_x.last**2 * full_y.last**2 * sum(y_in_divisible_by_x(2)))/
			 (((full_y.last - full_y.first) * sum(y_in_divisible_by_x(1)) + full_x.last * full_y.first) *
				((full_y.last + full_x.last * full_y.last) * sum(y_in_divisible_by_x(2)) + full_x.last * sum(y_in_divisible_by_x(2, 1)) +
					 (full_x.last * (full_y.first - full_y.last) - full_y.first) * sum(y_in_divisible_by_x(1)) + full_x.last * sum(y_in_divisible_by_x(1, 1))
				)
			)
  end

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
