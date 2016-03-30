require 'byebug'
# 2 inputs
#   - amount of money (integer or string)
#   - array of coin denominations (what each coin is available)

  # FIRST
  #   - remove any number bigger than the value
  #   - sort Array
  #   - remove any number thats 0

  amount = 4
  denominations = [1,2,3]
  total_index = denominations.count - 1

  denominations.sort
  cleaned_denominations = denominations.reject { |i| i == 0 }

  num_possibilities = 0


ways_of_doing_n_cents_with_1 = [ 1, 1, 1, 1 ]

# denominations.each do |num|
#   amount % num 
# end


def change_possibilities_bottom_up(amount, denominations)
    ways_of_doing_n_cents = [0] * (amount + 1)
    ways_of_doing_n_cents[0] = 1

    denominations.each do |coin|
        (coin..amount).each do |higher_amount|
            higher_amount_remainder = higher_amount - coin
            ways_of_doing_n_cents[higher_amount] += ways_of_doing_n_cents[higher_amount_remainder]
        end
    end

    return ways_of_doing_n_cents[amount]
end
puts change_possibilities_bottom_up(amount, denominations)

##############################
##############################
  # cleaned_denominations.each_with_index do |denomination, i|
  #   amount_iterations = 1
  #   while amount_iterations <= (amount / denomination)
  #     denomination_index = 0
  #     while denomination_index <= total_index
  #       if i + denomination_index <= total_index
  #         if denomination_index == 0
  #           if (amount - (denomination * amount_iterations)) == 0
  #             num_possibilities += 1
  #           end
  #         else
  #           if (amount - (denomination * amount_iterations + cleaned_denominations[i + denomination_index])) == 0
  #             num_possibilities += 1
  #           end
  #         end
  #       end
  #       denomination_index += 1
  #     end
  #     amount_iterations += 1
  #   end
  # end
  #
  # puts num_possibilities
##############################
##############################

  class Change
    def initialize
        @memo = {}
    end

    def change_possibilities_top_down(amount_left, denominations_left)
        memo_key = [amount_left, denominations_left].to_s
        if @memo.include? memo_key
            return @memo[memo_key]
        end

        return 1 if amount_left == 0
        return 0 if amount_left < 0
        return 0 if denominations_left.length == 0


        # choose a current coin
        current_coin, rest_of_coins = denominations_left[0], denominations_left[1..-1]

        # see how many possibilities we can get
        # for each number of times to use current_coin
        num_possibilities = 0
        while amount_left >= 0
            num_possibilities += change_possibilities_top_down(amount_left, rest_of_coins)
            amount_left -= current_coin
        end

        # save the answer in our memo so we don't compute it again
        @memo[memo_key] = num_possibilities
        return num_possibilities
    end
end
puts Change.new.change_possibilities_top_down(amount, denominations)
