require 'pry'
require 'yaml'

class Transaction
  attr_reader :balance

  def initialize(accounts)
    @accounts = accounts
  end

  def first_time
    initial_deposit
    yaml_file
  end

  def initial_deposit
    @balance = 0
    puts "Make your initial deposit"
    print "> "
    deposit = gets.chomp.to_f
    @balance += deposit
  end

  def yaml_file
    user = []
    @accounts.each do |account|
      user << account
    end
    user = user.to_yaml

    File.open('account.yml', 'w') do |file|
      file.puts user
    end
  end

  def deposit
  end

  def withdrawl
  end

end
