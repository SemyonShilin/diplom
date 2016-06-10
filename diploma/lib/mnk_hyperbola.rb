require 'mathn'
require 'matrix'
require_relative 'methods'

class Hyperbola
  include Methods

  attr_reader :x, :y, :full_x, :full_y

  def initialize(id, gene)
    @x = id
    @y = gene
  end

  def coefficient_a
    (x.last*y.last + (y.last-y.first)*coefficient_d)/x.last
  end

  def coefficient_b
    y.first*coefficient_d
  end

  def coefficient_d
    -(determinant_k2 / general_determinant)
  end

  private

  def general_determinant
    Matrix[[sum(x_in_degree_n), sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y)],
           [sum(x_in_degree_n_on_y), sum(y_in_degree_n(1)), sum(y_in_degree_n)],
           [sum(x_in_degree_n(1)), sum(y_in_degree_n(1)), x.size]].det
  end

  def determinant_k1
    Matrix[[sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y)],
           [sum(mult(x_in_degree_n_on_y, y_in_degree_n(1))), sum(y_in_degree_n(1)), sum(y_in_degree_n)],
           [sum(x_in_degree_n_on_y), sum(y_in_degree_n(1)), x.size]].det
  end

  def determinant_k2
    Matrix[[sum(x_in_degree_n), sum(x_in_degree_n_on_y(2)), sum(x_in_degree_n_on_y)],
           [sum(x_in_degree_n_on_y), sum(mult(x_in_degree_n_on_y, y_in_degree_n(1))), sum(y_in_degree_n)],
           [sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y), x.size]].det
  end

  def determinant_k3
    Matrix[[sum(x_in_degree_n), sum(x_in_degree_n(1)), sum(x_in_degree_n_on_y(2))],
           [sum(x_in_degree_n_on_y), sum(y_in_degree_n(1)), sum(mult(x_in_degree_n_on_y, y_in_degree_n(1)))],
           [sum(x_in_degree_n(1)), sum(y_in_degree_n(1)), sum(x_in_degree_n_on_y)]].det
  end
end
