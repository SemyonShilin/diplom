require 'gnuplot'
require_relative 'mnk_hyperbola'
require_relative 'sum_approximation_module'

class PlotHyp

	include SumApproximation

	attr_accessor :x, :y
	attr_reader :ob, :gn

	def initialize(obn, gene_id)
		@ob = obn
		@gn = gene_id
		@x, @y = [], []
	end

	def plotting_equation
		Gnuplot.open do |gp|
			Gnuplot::Plot.new( gp ) do |plot|

				plot.title  "Hyperbola"
				plot.ylabel "#{gn}"
				plot.xlabel "Calibration ID"

				@x = ob.full_x.collect { |v| v.to_f }
				@y = x.collect do |v|
					(ob.coefficient_a*v + ob.coefficient_b)/(v + ob.coefficient_d)
				end

				plot.data = [
										Gnuplot::DataSet.new( [x, ob.full_y] ) do |ds|
											ds.with = "points"
											ds.title = "Data"
											ds.linewidth = 2
										end,

										Gnuplot::DataSet.new( [x, y] ) do |ds|
											ds.with = "linespoints"
											ds.title = "Approximation data"
										end,

										mistake_written_in_title
										]
			end
		end
	end

end
