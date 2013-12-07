#Individual User
#Views his/her account
#Main page
class Atm
  attr_reader :account, :accounts

  def initialize
    @accounts = []
    @current_account = 0
  end

  def display_and_yaml
    read_in_yaml
    display_menu
  end

  def read_in_yaml
    @pin_name = {}
    if File.zero?('account.yml')
      0
    else
      people_file = File.open('account.yml', 'r')
      loaded_people = YAML.load(people_file)
      @accounts = []
      loaded_people.each do |people_list|
          binding.pry
        people_list.each do |people|
          binding.pry
          @name = people[1]
          @pin = people[0]
          @pin_name[@pin] = @name
        end
      end
        @accounts << @pin_name
        @current_account += @accounts.count
    end
  end

  def display_menu
    puts "What would you like to do?"
    puts "1 - Create a new account"
    puts "2 - Sign in"
  end

  def method_for_option(option)
    option_methods_choice[option]
  end

  def option_methods_choice
    { '1' => :sign_up,
      '2' => :sign_in }
  end

  def sign_up
    while @accounts.count == @current_account
      @argument = {
                  'name'        => name_input,
                  'pin'         => pin_input,
                  'pin_confirm' => pin_confirmation
                  }
      @account = Account.new(@argument)
      if @account.unique_pin?
        account_info = {}
        account_info[@account.pin] = @account.name
        @accounts << account_info
        @current_account += 2
      end
    end
    account_first
  end

  def account_first
    Transaction.new(@accounts).first_time
  end

  def sign_in
    info = { 'name' => name_input,
                'pin'  => pin_input }
    account_info = Account.new(info)
    account_info.account_view if account_info.match_pin?
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
