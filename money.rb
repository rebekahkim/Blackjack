# class Money
# 	def initialize(bet)
# 		@user_money = 100
# 		@bet = bet
# 	end

	def valid_bet?(bet)
		if bet > @user_money
			false
		end
	end

# 	def blackjack_win
# 		@user_money + @bet * 1.5
# 	end

# 	def win_bet
# 		@user_money + @bet
# 	end

# 	def lose_bet
# 		@user_money - @bet
# 	end

# end
