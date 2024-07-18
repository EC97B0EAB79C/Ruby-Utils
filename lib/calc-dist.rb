require_relative "array-tools"

class CalcDist
  def initialize(data_set)
    @data_set = data_set.sort
  end

  def median
    len = @data_set.length
    (@data_set[(len - 1) / 2] + @data_set[len / 2]) / 2.0
  end

  def quartiles
    q2 = median
    mid_index = @data_set.length / 2
    q1 = ArrayTools.median @data_set[0...mid_index]
    q3 = ArrayTools.median @data_set[(@data_set.length.even? ? mid_index : mid_index + 1)..-1]
    [q1, q2, q3]
  end

  def whiskers
    q1, q2, q3 = quartiles
    iqr = q3 - q1
    lower_fence = q1 - 1.5 * iqr
    upper_fence = q3 + 1.5 * iqr

    lower_whisker = @data_set.select { |x| x >= lower_fence }.min
    upper_whisker = @data_set.select { |x| x <= upper_fence }.max

    [lower_whisker, upper_whisker]
  end
end

begin
end
