require 'byebug'

class FireFlyCatcher
  def initialize(bug_array:, limit:)
    @bug_array = bug_array
    @limit = limit
    evaluate_value
  end

  def evaluate_value_index
    @highest_value = 0
    @order_of_index = []
    @bug_array.each_with_index do |bug, i|
      if @highest_value < (bug[1] / bug[0])
        @highest_value = (bug[1] / bug[0])
        @index = i
      end
    end
    @index
  end

  def calculate_how_many_of_each_type_to_catch
    count = {}
    while @limit < 20
      count[@index] = (@limit / @bug_array[@index][0])
      @limit -= (@limit * count[@index])
    end
  end

  def max_firefly_value
  end
end

firefly_arrays = [ [7, 160], [3, 90], [2, 15] ]
FireFlyCatcher.new(bug_array: firefly_arrays, limit: 20).max_firefly_value
