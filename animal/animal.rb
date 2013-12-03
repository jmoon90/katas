class Animal
  attr_reader :name
  def initialize
  end

  def sound
    "ajclvkja"
  end

  def emote
    puts "The #{self.class} makes the sound #{sound}"
  end
end

class Duck < Animal
  def sound
    puts "quack"
  end
end

class Cat < Animal
  def sound
    puts "meow"
  end
end

class Dog < Animal
  def sound
    puts "woof woof"
  end
end

new_duck = Duck.new
new_duck.emote

new_dog = Dog.new
new_dog.emote

new_cat = Cat.new
new_cat.emote
