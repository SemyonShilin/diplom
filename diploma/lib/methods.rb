module Methods

	private

	def sum(array)
		array.inject(0){|result, elem| result + elem}
	end

	def x_in_degree_n(n = 2)
		x.map{|x_i| x_i**n}
	end

	def y_in_degree_n(n = 2)
		y.map{|y_i| y_i**n}
	end

	def x_in_degree_n_on_y(n = 1)
		temp = []
		(x.size).times do |index|
			temp << x_in_degree_n(n)[index] * y[index]
		end
		temp
	end

	def y_in_divisible_by_x(n1, n2 = 0)
		temp = []
		(x.size).times do |index|
			temp << y_in_degree_n(n2)[index] / x_in_degree_n(n1)[index]
		end
		temp
	end

end
