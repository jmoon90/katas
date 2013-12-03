require 'pry'
class Car
  @@makes_models = []
  def self.add_make(make, *model)
    models = []
    make_model = {}
    models << model
    make_model[make] = models
    @@makes_models << make_model
  end

  def self.valid_make?(make)
    puts @@makes_models.detect { |x| x[make]}.include?(make)
  end

  def self.valid_model?(make, model)
    car = @@makes_models.select { |hash| hash[make] }
    if car.empty?
      puts "false"
    else
      puts car[0][make][0].include?(model)
    end
  end
end

Car.add_make('ford', 'focus', 'taurus')
Car.add_make('toyota','camry','corolla')

Car.valid_make?('ford') # => true
Car.valid_model?('ford', 'taurus') # => true
Car.valid_model?('GMC', 'taurus') # => false

Car.valid_model?('toyota', 'camry') # => true
Car.valid_model?('toyota', 'taurus') # => false




