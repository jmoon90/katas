require 'byebug'
require 'benchmark'

class IndividualPurchaseProduct
  def initialize(array_of_integers)
    @array_of_integers = array_of_integers
    @array_of_products = []
    @products_of_ints_before_index = 1

    # multiply everything after the index 0
    # at index 1. @before_index =  3 * 4
    @products_of_ints_after_index = @array_of_integers[1..-1].inject(:*)
  end

  def calcualte_purchase_for_individual
    @array_of_integers.each_with_index do |number, index|
      duplicated_array = @array_of_integers.dup
      duplicated_array.delete_at(index)
      @array_of_products << duplicated_array.inject(:*)
    end
    @array_of_products
  end

  def calculate_purchase
    @array_of_integers.each_with_index do |num, index|

      # multiply everything before the index
      # at index 2. @before_index =  1 * 7
      products_of_ints_before_index(index)

      # divide current index number from total
      # at index 1. @before_index =  84 / 7
      @products_of_ints_after_index /= num unless index == 0
      @array_of_products <<  @products_of_ints_before_index * remainder(num)
    end
    @array_of_products
  end

  private

  def remainder(num)
    @products_of_ints_after_index
  end

  def products_of_ints_before_index(index)
    @products_of_ints_before_index *= @array_of_integers[index - 1] unless index == 0
  end
end

     # n = [2,1, 7, 3, 4,  1,3 ]
    n = Array.new(5000) { rand(1...9) }
 Benchmark.bm(7) do |x|
     x.report("class method 1:") { IndividualPurchaseProduct.new(n).calcualte_purchase_for_individual }
     x.report("class method 2:") { IndividualPurchaseProduct.new(n).calculate_purchase }
 end
