require 'byebug'
require 'benchmark'

class HardWordDictionary
  def initialize(words: words, index: 1)
    @words = words
    @index = index
    @half_way_index = @words.length / 2
    @first_word = @words[0][0]
  end

  def find_index_of_the_rotataion_point
    if @words.length == 3
      if @first_word > @words[2][0]
        @index += @half_way_index
      end
      return puts @index
    elsif @first_word < half_way_word[0]
      @index += @half_way_index
      @words = @words[@half_way_index..-1]
    else #@words.first[0] > half_way_word[0]
      @words = @words[0..@half_way_index]
    end

    repeat_process_to_find_index_of_the_rotation_point
  end

  def repeat_process_to_find_index_of_the_rotation_point
    HardWordDictionary.new(words: @words, index: @index).find_index_of_the_rotataion_point
  end

  def half_way_word
    @words[@half_way_index]
  end
end

def read_one_by_one
  WORDS.each_with_index do |word, i|
    if word[0] =='b'
      return puts i
    end
  end
end

WORDS = [ 'ptolemaic', 'retrograde', 'sorry', 'supplant', 'undulate', 'xenoepist', 'zealot', 'zebra', 'babka', 'banoffee', 'engender', 'karpatka', 'othellolagkage']


HardWordDictionary.new(words: WORDS).find_index_of_the_rotataion_point
read_one_by_one


# Benchmark.bm(7) do |x|
#   x.report('class') {HardWordDictionary.new(words: WORDS).find_index_of_the_rotataion_point}
#   x.report('sort') {read_one_by_one}
# end
#
