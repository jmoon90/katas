require 'byebug'
require 'benchmark'

class IndividualPurchaseProduct
  def initialize(array_of_integers)
    @array_of_integers = array_of_integers
    @array_of_products = []
  end

  def calcualte_purchase_for_individual
    @array_of_integers.each_with_index do |number, index|
      duplicated_array = @array_of_integers.dup
      duplicated_array.delete_at(index)
      @array_of_products << duplicated_array.inject(:*)
    end
    @array_of_products
  end
end

n = Array.new(5000) { rand(1...9) }
Benchmark.bm(7) do |x|
  x.report("class:") { IndividualPurchaseProduct.new(n).calcualte_purchase_for_individual}
end
