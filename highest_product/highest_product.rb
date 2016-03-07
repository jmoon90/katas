require 'byebug'
require 'benchmark'

class HighestProductFinder
  def initialize(array_of_ints)
    @sorted_array ||= array_of_ints.sort
  end

  def highest_product
    greater = check_who_is_greater(sorted_array[-3..-2].inject(:*), sorted_array[0..1].inject(:*))
    greater * sorted_array[-1]
  end

  private

  attr_reader :sorted_array

  def check_who_is_greater(second_and_third, bottom_two)
    if second_and_third > bottom_two
      second_and_third
    else
      bottom_two
    end
  end
end

class HighestProductFinderCopy
  def initialize(array_of_ints)
    @sorted_array ||= array_of_ints.sort
    @second_and_third ||= sorted_array[-3..-2].inject(:*)
    @bottom_two ||= sorted_array[0..1].inject(:*)
    @biggest_int ||= sorted_array[-1]
  end

  def highest_product
    @biggest_int * get_greater_product(@second_and_third, @bottom_two)
  end

  private

  attr_reader :sorted_array

  def get_greater_product(second_and_third, bottom_two)
    if second_and_third > bottom_two
      second_and_third
    else
      bottom_two
    end
  end
end
ARRAY_OF_INTS = Array.new(3) { rand(-30...30) }

puts HighestProductFinder.new(ARRAY_OF_INTS).highest_product
puts HighestProductFinderCopy.new(ARRAY_OF_INTS).highest_product

# Benchmark.bm(7) do |x|
#   x.report('Finder')  {HighestProductFinder.new(ARRAY_OF_INTS).highest_product}
#   x.report('Finder Copy')  {HighestProductFinderCopy.new(ARRAY_OF_INTS).highest_product}
# end
