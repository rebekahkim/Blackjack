# IN PROGRESS
# New blackjack with database
# Working with MySQL database managing

require 'mysql2'
require_relative 'card'

class Game
	def initialize(id)

		@id = id
		@mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		# pull cards from db
		@shuffled_deck = []

		@mysql.query("SELECT * FROM game_cards WHERE game_id = #{@id}").each{|row|
			@shuffled_deck << Card.new(row['suit'], row['face'])
		}
		#if no cards, create default deck
		if @shuffled_deck.empty?
			@shuffled_deck = Card.deck.shuffle
			@shuffled_deck.each{|card|
				puts card.display
			}
		end

		@user_hand = []
		@dealer_hand = []

		2.times do
			@user_hand << @shuffled_deck.pop
			@dealer_hand << @shuffled_deck.pop
		end

		# puts @mysql.query("SELECT * FROM games WHERE id = #{@id}").to_a
		@user_money = @mysql.query("SELECT * FROM games WHERE id = #{@id}").first['money']	#INSERT is adding row, which is fast unlike columns

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

		puts "Would you like to (s)ave? Press any other key to not save."
		save = gets.chomp
		if save == 's'
			@mysql.query "UPDATE games SET money = #{@user_money} WHERE id = #{@id}"

			@mysql.query "DELETE FROM game_cards WHERE game_id = #{@id}"
			@shuffled_deck.each{|card|
				@mysql.query "INSERT INTO game_cards(face, suit, game_id)
					VALUES('#{card.face}', '#{card.suit}', #{@id} )"
			}
		end

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

	def run 
		until self.end?
				puts
				puts '===================='
				puts "|| Bankroll: $ #{self.display_money} ||"
				puts '===================='													
				puts
				print '===> Place bet: $ '
				bet = gets.to_i

				puts " Card Room                   
			 ______________________________________________
			|                                              |
			| .-------.  .-------.  .-------.  .-------.   |
			| |   _   |  |   *   |  | ** ** |  |  / \\  |   |
			| | _( )_ |  | *   * |  |*  *  *|  | /   \\ |   |
			| |(_   _)|  |*     *|  | *   * |  | \\   / |   |
			| |   I   |  |  *I*  |  |   *   |  |  \\ /  |   |
			| |  CLUB |  | SPADE |  | HEART |  |DIAMOND|   |
			| `-------'  `-------'  `-------'  `-------'   |
			|                                              |
			|        ______________________________        |
			|       /     +         +        +     \\       |
			|______ ********************************_______|
			        ********************************         
			        ||||                         |||
			        ||                            ||
			        ||                            ||"

				if self.valid_bet?(bet)
					puts
					puts "Your hand: "
					 "#{self.display}"
					puts ">Sum: #{self.user_sum}"
					puts
					puts "Dealer's card: #{self.display_dealer}"
					puts
					self.dealer_sum

					if self.blackjack_draw?
						puts "PUSH: Both you and the dealer got blackjacks"
						puts
						self.new_hand
					else
						if self.user_blackjack?
							puts "WIN: You got a blackjack!"
							self.blackjack_bet_win(bet)
							self.new_hand

						elsif self.dealer_blackjack?
							puts "LOSE: The dealer got a blackjack"
							self.blackjack_bet_lose(bet)
							self.new_hand
						else
							loop do
								print "(h)it or (st)and?: "
								move = gets.chomp

								case move
									when 'h'
										puts '-----------'
										puts ">>> HIT <<<"
										puts '-----------'
										puts
										self.hit_user
										self.user_sum
					 					puts
										if self.bust?
					 						puts
											puts "BUST"
											puts
											self.bet_lose(bet)
											self.new_hand
											break
										else
											puts "Your hand: "
											 "#{self.display}"
											puts ">Sum: #{self.user_sum}"
											puts
											puts "Dealer's card: #{self.display_dealer}"
											puts
											if self.dealer_sum < 17
												self.hit_dealer
											end
										end											

									when 'st'
										puts '-------------'
										puts ">>> STAND <<<"
										puts '-------------'

										while self.dealer_sum < 17
											self.hit_dealer
										end

										self.user_sum
										self.dealer_sum

										if self.draw?
											puts "PUSH"
											puts
											self.new_hand
										else
											if self.win?
												puts "WIN"
												self.bet_win(bet)
												puts
												self.new_hand
												puts
											else
												puts "LOSE"
												puts
												self.bet_lose(bet)
												self.new_hand
												puts
											end
										end

										break
									
									when 'D'
										puts "DOUBLE"
									when 'SP'
										puts "SPLIT"
									when "SR"
										puts "SURRENDER"
									else
										puts "Please enter 'H' or 'S' to hit or stand"
										puts
								end
							end
						end

					end
				else
					puts "Please bet $#{self.display_money} or lower"
					puts
				end

		end
	end
end




