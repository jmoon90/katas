require 'byebug'
require 'benchmark'

class HardWordDictionary
  def initialize(words)
    @words = words
  end

  def index_of_the_rotataion_point
    if @words.length == 2
      return puts @words.sort.first
    elsif @words.first[0] < half_way_word[0]
      # we can subtract 1 to 0 and add 1 from halfway as these aren't A
      @words = @words[halfway..-1]
    elsif @words.first[0] > half_way_word[0]
      @words = @words[0..halfway]
    end
    HardWordDictionary.new(@words).index_of_the_rotataion_point
  end

  def halfway
    (@words.length) / 2
  end

  def half_way_word
    @words[halfway]
  end
end

WORDS = [ 'ptolemaic', 'retrograde', 'supplant', 'undulate', 'xenoepist', 'apple', 'asymptote', 'babka', 'banoffee', 'engender', 'karpatka', 'othellolagkage']

puts HardWordDictionary.new(WORDS).index_of_the_rotataion_point
puts WORDS.sort.first

# Benchmark.bm(7) do |x|
#   x.report('class') {HardWordDictionary.new(WORDS).index_of_the_rotataion_point}
#   x.report('sort') {WORDS.sort.first}
# end
#
