require 'pry'
#Checks user PIN to account pin and decides
#the correct user or tells them they need to create an account
class Account < Atm
  def initialize(argument)
    @name = argument[:name]
    @pin = argument[:pin]
    @pin_confirmation = argument[:pin_confirm]
  end

  def unique_pin?
    @pin == @pin_confirmation
  end

  def deposit_message
    puts "How much would you like to deposit?"
    print "> "
    current_deposit = gets.chomp
  end

  def transaction
    #has many transaction
    #Directs to the transaction class
  end

  def balance
  end
end
