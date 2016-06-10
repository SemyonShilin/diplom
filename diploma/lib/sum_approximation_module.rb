module SumApproximation
  private

  def mistake_written_in_title
    Gnuplot::DataSet.new([0, 0]) do |ds|
      ds.title = "Mistake: #{sum_approximation(ob.y, y)}"
    end
  end

  def sum_approximation(y, y_a)
    sum = 0
    y.size.times do |index|
      sum += (y[index] - y_a[index])**2
    end
    sum
  end
end
