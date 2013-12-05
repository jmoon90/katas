require 'pry'
require_relative 'atm'
require_relative 'account'
require_relative 'transaction'

puts 'Welcome to the Bank. The bank is always open, unless it is closed.'
puts "------------------------------------------------------------------.\n"

atm = Atm.new
atm.display_menu
menu_choice = atm.method_for_option(gets.chomp)
atm.send(menu_choice)
