require 'benchmark'
require 'byebug'

class ThermostatTracker
  attr_accessor :temperatures
  def initialize(temperatures)
    @temperatures = temperatures
  end

  def get_max
    temperatures.max
  end

  def get_min
    temperatures.min
  end

  def get_mean
    temperatures.inject(:+) / temperatures.count.to_f
  end

  def get_mode
    mode_hash = Hash.new(0)
    temperatures.each do |temp|
      mode_hash[temp] += 1
    end

    mode_max = mode_hash.map do |k,v|
      k if v ==  mode_hash.values.max
    end
    mode_max.compact
  end

  def temperatures
    @temperatures ||= Array.new(20) { rand(0..10) }
  end

  def new_temperature(new_temp)
    temperatures << new_temp
  end
end

temps = Array.new(2000000) { rand(0..110) }
thermostat_tracker = ThermostatTracker.new(temps)



class TempTracker

    def initialize

        # for mode
        @occurrences = [0] * (111) # array of 0s at indices 0..110
        @max_occurrences = 0
        @mode = nil

        # for mean
        @total_numbers = 0
        @total_sum = 0.0 # mean should be float
        @mean = nil

        # for min and max
        @min_temp = nil
        @max_temp = nil
    end

    def insert(temperature)

        # for mode
        @occurrences[temperature] += 1
        if @occurrences[temperature] > @max_occurrences
            @mode = temperature
            @max_occurrences = @occurrences[temperature]
        end

        # for mean
        @total_numbers += 1
        @total_sum += temperature
        @mean = @total_sum / @total_numbers

        # for min and max
        if @max_temp.nil? or temperature > @max_temp
            @max_temp = temperature
        end
        if @min_temp.nil? or temperature < @min_temp
            @min_temp = temperature
        end
    end

    def get_max
        return @max_temp
    end

    def get_min
        return @min_temp
    end

    def get_mean
        return @mean
    end

    def get_mode
        return @mode
    end
end

Benchmark.bm(7) do |x|
  x.report("my mean") { ThermostatTracker.new(temps).get_mean }
  x.report("my mode") { ThermostatTracker.new(temps).get_mode }
  # x.report("his mean") { TempTracker.new.insert(temps).mean }
  # x.report("his mode") { TempTracker.new.insert(temps).mode }
end

