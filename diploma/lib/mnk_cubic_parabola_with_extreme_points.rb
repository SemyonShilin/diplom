require 'mathn'
require 'matrix'
require_relative 'methods'

class CubicParabolaWithExtremes

  include Methods

  attr_reader :x, :y

  def initialize (id, gene)
    @x, @y = id, gene
  end

  def coefficient_a
    determinant_a/general_determinant
  end

  def coefficient_b
    determinant_b/general_determinant
  end


  def coefficient_c
    (y.last - coefficient_a * x.last**3 - coefficient_b * x.last**2 - y.first)/x.last
    # determinant_c/general_determinant
  end

  def coefficient_d
    y.first
  end

  private

  # def general_determinant
  #
  #   Matrix[[x.last * (sum(x_in_degree_n) * x.last**4 - sum(x_in_degree_n(4)) * 2 * x.last**2 + sum(x_in_degree_n(6))), x.last * (sum(x_in_degree_n) * x.last**3 - sum(x_in_degree_n(3)) * x.last**2 - x.last * sum(x_in_degree_n(4)) + sum(x_in_degree_n(5)))],
  #          [x.last * (sum(x_in_degree_n) * x.last**3 - 2 * x.last * sum(x_in_degree_n(4)) - sum(x_in_degree_n(3)) * x.last**2 + sum(x_in_degree_n(5))), x.last * (sum(x_in_degree_n) * x.last**2 - 2 * x.last * sum(x_in_degree_n(3)) + sum(x_in_degree_n(3)))]
  #         ].det
  # end
  #
  # def determinant_a
  #   Matrix[[x.last * sum(x_in_degree_n_on_y(3)) - (y.last - y.first) * sum(x_in_degree_n(4)) - x.last * y.first * sum(x_in_degree_n(3)) - sum(x_in_degree_n_on_y) * x.last**3 + (y.last - y.first) * sum(x_in_degree_n) * x.last**2 - y.first * sum(x) * x.last**3, x.last * (sum(x_in_degree_n) * x.last**3 - sum(x_in_degree_n(3)) * x.last**2 - x.last * sum(x_in_degree_n(4)) + sum(x_in_degree_n(5)))],
  #          [x.last * sum(x_in_degree_n_on_y(2)) - (y.last - y.first) * sum(x_in_degree_n(3)) - x.last * y.first * sum(x_in_degree_n) - sum(x_in_degree_n_on_y) * x.last**2 + x.last * (y.last - y.first) * sum(x_in_degree_n) + y.first * sum(x) * x.last**2, x.last * (sum(x_in_degree_n) * x.last**2 - 2 * x.last * sum(x_in_degree_n(3)) + sum(x_in_degree_n(3)))]
  #         ].det
  # end
  #
  # def determinant_b
  #   Matrix[[x.last * (sum(x_in_degree_n) * x.last**4 - sum(x_in_degree_n(4)) * 2 * x.last**2 + sum(x_in_degree_n(6))), x.last * sum(x_in_degree_n_on_y(3)) - (y.last - y.first) * sum(x_in_degree_n(4)) - x.last * y.first * sum(x_in_degree_n(3)) - sum(x_in_degree_n_on_y) * x.last**3 + (y.last - y.first) * sum(x_in_degree_n) * x.last**2 - y.first * sum(x) * x.last**3],
  #          [x.last * (sum(x_in_degree_n) * x.last**3 - 2 * x.last * sum(x_in_degree_n(4)) - sum(x_in_degree_n(3)) * x.last**2 + sum(x_in_degree_n(5))), x.last * sum(x_in_degree_n_on_y(2)) - (y.last - y.first) * sum(x_in_degree_n(3)) - x.last * y.first * sum(x_in_degree_n) - sum(x_in_degree_n_on_y) * x.last**2 + x.last * (y.last - y.first) * sum(x_in_degree_n) + y.first * sum(x) * x.last**2]
  #         ].det
  # end

  def general_determinant
    Matrix[[sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n)],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3))],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n(5)), sum(x_in_degree_n(4))]
    ].det
  end

  def determinant_a
    Matrix[[sum(x_in_degree_n_on_y) - y.first*sum(x_in_degree_n(1)), sum(x_in_degree_n(3)), sum(x_in_degree_n)],
           [sum(x_in_degree_n_on_y(2)) - y.first*sum(x_in_degree_n(2)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3))],
           [sum(x_in_degree_n_on_y(3)) - y.first*sum(x_in_degree_n(3)), sum(x_in_degree_n(5)), sum(x_in_degree_n(4))]
    ].det
  end

  def determinant_b
    Matrix[[sum(x_in_degree_n(4)), sum(x_in_degree_n_on_y) - y.first*sum(x_in_degree_n(1)), sum(x_in_degree_n)],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n_on_y(2)) - y.first*sum(x_in_degree_n(2)), sum(x_in_degree_n(3))],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n_on_y(3)) - y.first*sum(x_in_degree_n(3)), sum(x_in_degree_n(4))]
    ].det
  end

  def determinant_c
    Matrix[[sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n_on_y) - y.first*sum(x_in_degree_n(1))],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n_on_y(2)) - y.first*sum(x_in_degree_n(2))],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n(5)), sum(x_in_degree_n_on_y(3)) - y.first*sum(x_in_degree_n(3))]
    ].det
  end

end
