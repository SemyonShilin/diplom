$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
path = File.expand_path(" . ")
require "#{path}\\mnk_cubic_parabola"
require "gnuplot"


class Plot

	def initialize(obn)
		@ob = obn
	end
	
	attr_accessor :ob

	def ff					
		Gnuplot.open do |gp|
			Gnuplot::Plot.new( gp ) do |plot|
			
				plot.title  "Cubic Parabola"
				plot.ylabel "gene"
				plot.xlabel "Calibration ID"
				
				x = ob.x.collect { |v| v.to_f }
				y = x.collect do
					|v| ob.coefficient_a * v**3 + ob.coefficient_b * v**2 + ob.coefficient_c * v + ob.coefficient_d
				end

				plot.data = [
											Gnuplot::DataSet.new( [x, ob.y] ) { |ds|
												ds.with = "points"
												ds.title = "data"
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