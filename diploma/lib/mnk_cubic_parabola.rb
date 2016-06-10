require 'mathn'
require 'matrix'
require_relative 'methods'

class CubicParabola
  include Methods

  attr_reader :x, :y

  def initialize(id, gene)
    @x = id
    @y = gene
  end

  def coefficient_a
    determinant_a / general_determinant
  end

  def coefficient_b
    determinant_b / general_determinant
  end

  def coefficient_c
    determinant_c / general_determinant
  end

  def coefficient_d
    determinant_d / general_determinant
  end

  private

  def general_determinant
    Matrix[[sum(x_in_degree_n(3)), sum(x_in_degree_n), sum(x), x.size],
           [sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n), sum(x)],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n)],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3))]].det
  end

  def determinant_a
    Matrix[[sum(y), sum(x_in_degree_n), sum(x), x.size],
           [sum(x_in_degree_n_on_y), sum(x_in_degree_n(3)), sum(x_in_degree_n), sum(x)],
           [sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n)],
           [sum(x_in_degree_n_on_y(3)), sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3))]].det
  end

  def determinant_b
    Matrix[[sum(x_in_degree_n(3)), sum(y), sum(x), x.size],
           [sum(x_in_degree_n(4)), sum(x_in_degree_n_on_y), sum(x_in_degree_n), sum(x)],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n(3)), sum(x_in_degree_n)],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n_on_y(3)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3))]].det
  end

  def determinant_c
    Matrix[[sum(x_in_degree_n(3)), sum(x_in_degree_n), sum(y), x.size],
           [sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n_on_y), sum(x)],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n)],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n(5)), sum(x_in_degree_n_on_y(3)), sum(x_in_degree_n(3))]].det
  end

  def determinant_d
    Matrix[[sum(x_in_degree_n(3)), sum(x_in_degree_n), sum(x), sum(y)],
           [sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n), sum(x_in_degree_n_on_y)],
           [sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n(3)), sum(x_in_degree_n_on_y(2))],
           [sum(x_in_degree_n(6)), sum(x_in_degree_n(5)), sum(x_in_degree_n(4)), sum(x_in_degree_n_on_y(3))]].det
  end
end
