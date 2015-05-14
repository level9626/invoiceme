# Patch for Numeric class that allows to do things like:
# Note: the brackets () around number are optional
# p (1).percent_of(10)    # => 10.0  (%)
# p (200).percent_of(100) # => 200.0 (%)
# p (0.5).percent_of(20)  # => 2.5   (%)
#
# pizza_slices = 5
# eaten = 3
# p eaten.percent_of(pizza_slices) # => 60.0 (%)
class Numeric
  def percent_of(n)
    return 0 unless n
    self.to_f / n.to_f * 100.0
  end
end