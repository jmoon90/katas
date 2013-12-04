require_relative("pig_latin_translation")

puts "Welcome to John's Pig Latin Translation Script"
puts "----------------------------------------------"
puts "What phrase would you like me to translate?"
print "> "
phrase = gets.chomp


PigLatinTranslation.new(phrase)
