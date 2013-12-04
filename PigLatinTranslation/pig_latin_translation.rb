require 'pry'
class PigLatinTranslation
  def initialize(phrase)
  @phrase = phrase
  words
  end

  #provide the pig latin translation
  def translate
  end

  private
  #an array of words in the phrase
  def words
    words = @phrase.split(" ")
    words.each do |word|
      starts_with_vowel?(word)
      consonant_letter?(word)
    end
  end

  def starts_with_vowel?(word)
    vowel = ['a', 'e', 'i', 'o', 'u']
    puts word + "way" if vowel.include?(word[0])
  end

  def consonant_letter?(word)
    consonant = ['b', 'c', 'd', 'f', 'g', 'h', 'j',
                 'r', 'l', 'm', 'n', 'p', 'q', 'r',
                 's', 't', 'v', 'w', 'y', 'z']
     if consonant.include?(word[0])
        letter = word.split('')
        first = letter.shift
        new_word = first + "ay"
        puts letter.join('') + new_word
     end
  end
end

PigLatinTranslation.new("happy duck glove egg inbox eight")
