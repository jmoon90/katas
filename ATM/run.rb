require 'pry'
require_relative 'atm'
require_relative 'account'

puts 'Welcome to the Bank. The bank is always open, unless it is closed.'
puts "------------------------------------------------------------------.\n"

atm = Atm.new
atm.display_menu
menu_choice = atm.method_for_option(gets.chomp)
atm.send(menu_choice)

account = Account.new
account.deposit


