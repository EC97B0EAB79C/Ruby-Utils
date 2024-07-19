require_relative "array-tools"

##
# Calculate Distribution
class CalcDist
  def initialize(data_set)
    @data_set = data_set
      .select { |element| element.is_a?(Integer) || element.is_a?(Float) }
      .sort
    @len = @data_set.length
  end

  def nan?
    @len.zero?
  end

  # Box Plot Related
  def median
    return "NaN" if nan?
    (@data_set[(@len - 1) / 2] + @data_set[@len / 2]) / 2.0
  end

  def quartiles
    return "NaN" if nan?
    q2 = median
    mid_index = @len / 2
    q1 = ArrayTools.median @data_set[0...mid_index]
    q3 = ArrayTools.median @data_set[(@len.even? ? mid_index : mid_index + 1)..-1]
    [q1, q2, q3]
  end

  def whiskers
    return "NaN" if nan?
    q1, q2, q3 = quartiles
    iqr = q3 - q1
    lower_fence = q1 - 1.5 * iqr
    upper_fence = q3 + 1.5 * iqr

    lower_whisker = @data_set.select { |x| x >= lower_fence }.min
    upper_whisker = @data_set.select { |x| x <= upper_fence }.max

    [lower_whisker, upper_whisker]
  end

  # Statistics
  def median
    return "NaN" if nan?
    @data_set.sum.to_f / @len
  end

  def variance
    return "NaN" if nan?
    m = median
    sum = @data_set.reduce(0) { |acc, i| acc + (i - m) * (i - m) }
    sum / @len
  end

  def sd
    return "NaN" if nan?
    Math.sqrt(variance)
  end
end
