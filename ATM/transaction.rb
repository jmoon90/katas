class Transaction < Account
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def first_time
    initial_deposit
  end

  def initial_deposit
    puts "Make your initial deposit"
    print "> "
    deposit = gets.chomp.to_f
    @balance += deposit
  end

  def deposit
  end

  def withdrawl
  end

end
