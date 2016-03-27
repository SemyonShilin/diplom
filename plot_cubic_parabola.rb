$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
path = File.expand_path(" . ")
require "#{path}\\mnk_cubic_parabola"
require "gnuplot"


class PlotCP

	def initialize(obn, gene_id)
		@ob = obn
		@gn = gene_id
	end

	attr_reader :ob, :gn

	def ploting_equation
		Gnuplot.open do |gp|
			Gnuplot::Plot.new( gp ) do |plot|

				plot.title  "Cubic Parabola"
				plot.ylabel "#{gn}"
				plot.xlabel "Calibration ID"

				x = ob.x.collect { |v| v.to_f }
				y = x.collect do
					|v| ob.coefficient_a * v**3 + ob.coefficient_b * v**2 + ob.coefficient_c * v + ob.coefficient_d
				end

				plot.data = [
											Gnuplot::DataSet.new( [x, ob.y] ) { |ds|
												ds.with = "points"
												ds.title = "Data"
												ds.linewidth = 2
											},

											Gnuplot::DataSet.new( [x, y] ) { |ds|
												ds.with = "linespoints"
												ds.title = "Approximation data"
											}
										]
			end
		end
	end

end
