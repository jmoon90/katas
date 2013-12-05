#Individual User
#Views his/her account
#Main page
class Atm
  attr_reader :account, :user, :pin, :pin_confirm
  def initialize
    @accounts = []
  end

  def display_menu
    puts "What would you like to do?"
    puts "1 - Create a new account"
  end

  def method_for_option(option)
    option_methods_choice[option]
  end

  def option_methods_choice
    { '1' => :sign_up }
  end

  def sign_up
    while @accounts.count == 0
      @argument = {
                  :name        => name_input,
                  :pin         => pin_input,
                  :pin_confirm => pin_confirmation
                  }

      @account = Account.new(@argument)
      @accounts << account if account.unique_pin?
    end
    transaction_class
  end

  def transaction_class
    Transaction.new.first_time
  end

  def name_input
    puts "What is your user name?"
    print "> "
    name = gets.chomp
    name
  end

  def pin_input
    puts "What is your pin?"
    print "> "
    pin = gets.chomp
    pin
  end

  def pin_confirmation
    puts "Confirm your pin"
    print "> "
    confirm_pin = gets.chomp
    confirm_pin
  end
end
