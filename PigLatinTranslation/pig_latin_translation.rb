class PigLatinTranslation
  def initialize(phrase)
    @phrase = phrase
    @translated_phrase = []
    words
    puts @translated_phrase.join(' ').capitalize
  end

  #provide the pig latin translation
  def translate(word)
    if starts_with_vowel?(word) == true
      @translated_phrase << (word + "way")
    elsif consonant_letter?(word) == true
      letter = word.split('')
      letters = []
      @count.times do
        letters << letter.shift
      end
      new_word = letters.join('') + "ay"
      @translated_phrase << (letter.join('') + new_word)
    end
  end

  private
  #an array of words in the phrase
  def words
    words = @phrase.split(" ")
    words.each do |word|
      translate(word)
    end
  end

  def starts_with_vowel?(word)
    vowel = ['a', 'e', 'i', 'o', 'u']
    vowel.include?(word[0])
  end

  def consonant_letter?(word)
    @count = 0
    consonant = ['b', 'c', 'd', 'f', 'g', 'h', 'j',
                 'r', 'l', 'm', 'n', 'p', 'q', 'r',
                 's', 't', 'v', 'w', 'y', 'z']
    word.split('').each do |letter|
      if consonant.include?(letter)
        @count += 1
      else
        break
      end
    end
    true
  end
end
