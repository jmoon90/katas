require 'pry'
#Checks user PIN to account pin and decides
#the correct user or tells them they need to create an account
class Account
  attr_reader :name, :pin, :pin_confirm
  def initialize(argument)
    @name = argument['name']
    @pin = argument['pin']
    @pin_confirm = argument['pin_confirm']
  end

  def account_view
    account_action
  end

  def unique_pin?
    @pin == @pin_confirm
  end

  def match_pin?
    binding.pry
    people_file = File.open('account.yml', 'r')
    loaded_people = YAML.load(people_file)
    loaded_people[0] == @name && loaded_people[1] == @pin
  end

  def initial_deposit
  end

  def account_action
    puts 'What would you like to do?(deposit, withdrawal, transaction)'
    print '> '
    if gets.chomp == 'deposit'
      deposit_message
    elsif gets.chomp == 'transaction'
      transaction_class
    else
      withdrawal_message
    end
  end

  def deposit_message
    puts "How much would you like to deposit?"
    print "> "
    transaction_class
  end

  def withdrawal_message
    puts "How much would you like to withdrawal?"
    print "> "
    transaction_class
  end

  def transaction_class
  end

  def balance
  end
end
