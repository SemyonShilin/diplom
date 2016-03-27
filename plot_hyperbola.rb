$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
path = File.expand_path(" . ")
require "#{path}\\mnk_hyperbola"
require "gnuplot"


class PlotHyp

	def initialize(obn, gene_id)
		@ob = obn
		@gn = gene_id
	end

	attr_reader :ob, :gn

	def ploting_equation
		Gnuplot.open do |gp|
			Gnuplot::Plot.new( gp ) do |plot|

				plot.title  "Hyperbola"
				plot.ylabel "#{gn}"
				plot.xlabel "Calibration ID"

				x = ob.full_x.collect { |v| v.to_f }
				y = x.collect do |v|
					(ob.coefficient_a*v + ob.coefficient_b)/(v + ob.coefficient_d)
				end

				plot.data = [
										Gnuplot::DataSet.new( [x, ob.full_y] ) { |ds|
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
