class Stack
  def initialize
    @items = []
  end

  attr_accessor :items

  def push(item)
    @items.push(item)
  end

  def pop()
    return nil if @items.empty?
    return @items.pop()
  end

  def peek()
    return nil if @items.empty?
    return @items[-1]
  end
end

class MaxStack < Stack
  def get_max
    @items.max
  end
end
