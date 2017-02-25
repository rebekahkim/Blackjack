

class Game
	def initialize
		@user_money = 100

		@shuffled_deck = Card.deck.shuffle
		# @shuffled_deck.each{|card|
		# 	puts card.display
		# }

		@user_hand = []
		@dealer_hand = []

		2.times do
			@user_hand << @shuffled_deck.pop
			@dealer_hand << @shuffled_deck.pop
		end
	end

	def deck
		@shuffled_deck = Card.deck.shuffle
		print @shuffled_deck

		@shuffled_deck.each{|card|
			puts card.display
		}
	end

	def end?
		game_over = false
		if @user_money == 1000
			puts "Congratulations! You won!"
			game_over = true
		elsif @user_money == 0
			puts 'You are bankrupt! Game over'
			puts
			game_over = true
		end
		game_over
	end

	def valid_bet?(bet)
		valid_bet = true
		if bet > @user_money
			valid_bet = false
		end
		valid_bet
	end

	def new_hand
		puts "Your hand: "
		@user_hand.each{|card|
			puts card.graphics(card)
		}
		puts ">Sum: #{@user_sum}"
		puts
		puts "Dealer's hand: "
		@dealer_hand.each{|card|
			puts card.graphics(card)
		}
		puts ">Sum: #{@dealer_sum}"
		puts
		@user_hand.clear
		@dealer_hand.clear
		2.times do
			@user_hand << @shuffled_deck.pop
			@dealer_hand << @shuffled_deck.pop
		end
	end

	def blackjack_draw?
		draw = false 
		if @user_sum == 21 && @dealer_sum == 21
			draw = true
		end
		draw
	end

	def user_blackjack?
		return true if @user_sum == 21
		false
	end

	def dealer_blackjack?
		bj = false
		if @dealer_sum == 21
			bj = true
		end
		bj
	end

	def dealer_sum
		@dealer_sum = 0
		@dealer_hand.each{|card|
			@dealer_sum += card.value
		}
		if @dealer_sum > 21
			num_ace = @dealer_hand.count{|card|
				card.face == 'A'
			}
			@dealer_sum -= num_ace * 10 		
		end
		
		@dealer_sum
	end	

	def user_sum
		@user_sum = 0
		@user_hand.each{|card|
			@user_sum += card.value
		}
		
		if @user_sum > 21
			num_ace = @user_hand.count{|card|
				card.face == 'A'
			}
			@user_sum -= num_ace * 10 		
		end

		@user_sum
	end

	def blackjack_bet_win(bet)
		@user_money = @user_money + bet * 1.5
	end

	def blackjack_bet_lose(bet)
		@user_money = @user_money - bet * 1.5
	end

	def bet_win(bet)
		@user_money = @user_money + bet
	end

	def bet_lose(bet)
		@user_money = @user_money - bet
	end

	def hit_user
		@user_hand << @shuffled_deck.pop
	end

	def hit_dealer
		@dealer_hand << @shuffled_deck.pop
	end

	def bust?
		return true if @user_sum > 21
		false
	end

	def draw?
		draw = false
		if @user_sum == @dealer_sum
			draw = true
		end
		return draw
	end

	def win?
		win = true
		if @user_sum < @dealer_sum
			if @dealer_sum > 21
				win = true
			else
				win = false
			end
		end
		win
	end

	def user_hand
		@user_hand
	end



	def display
		@user_hand.each{|card|
			puts card.graphics(card)
		}

		# puts card.graphics(card)
	end

	def display_dealer
		@dealer_hand.first.display
	end

	def display_money
		@user_money
	end
end




