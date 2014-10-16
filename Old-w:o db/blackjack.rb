# IN PROGRESS
# WORK ON:
# - Create Interface (Graphics) for the game
# - Give hints to user for moves
# - Enable user to save and exit the game
# - Add Split, Double, Insurance Features
#Blackjack Game

require_relative 'game'
require_relative 'card'

#sldkfjlskdfj

puts
puts"
    ?????????????????????????????????????? . ######################################
    ?????????????????????????????????????  %  #####################################
    ????????????????????????????????????  %*:  ####################################
    ???????????????????????????????????  %#*?:  ###################################
    ?????????????????????????????????  ,%##*??:.  #################################
    ???????????????????????????????  ,%##*?*#*??:.  ###############################
    ?????????????????????????????  ,%###*??*##*???:.  #############################
    ???????????????????????????  ,%####*???*###*????:.  ###########################
    ?????????????????????????  ,%####**????*####**????:.  #########################
    ???????????????????????  ,%#####**?????*#####**?????:.  #######################
    ??????????????????????  %######**??????*######**??????:  ######################
    ?????????????????????  %######**???????*#######**??????:  #####################
    ????????????????????  %######***???????*#######***??????:  ####################
    ????????????????????  %######***???????*#######***??????:  ####################
    ????????????????????  %######***???????*#######***??????:  ####################
    ?????????????????????  %######**??????***######**??????:  #####################
    ??????????????????????  '%######****:^%*:^%****??????:'  ######################
    ????????????????????????   '%####*:'  %*:  '%*????:'   ########################
    ??????????????????????????           %#*?:           ##########################
    ?????????????????????????????????  ,%##*??:.  #################################
    ???????????????????????????????  .%###***???:.  ###############################
    ??????????????????????????????                   ##############################
    ???????????????????????????????????????*#######################################
"
puts"
 _______   __                      __                 _____                      __       
|       \\ |  \\                    |  \\               |     \\                    |  \\      
| $$$$$$$\\| $$  ______    _______ | $$   __           \\$$$$$  ______    _______ | $$   __ 
| $$__/ $$| $$ |      \\  /       \\| $$  /  \\            | $$ |      \\  /       \\| $$  /  \\
| $$    $$| $$  \\$$$$$$\\|  $$$$$$$| $$_/  $$       __   | $$  \\$$$$$$\\|  $$$$$$$| $$_/  $$
| $$$$$$$\\| $$ /      $$| $$      | $$   $$       |  \\  | $$ /      $$| $$      | $$   $$ 
| $$__/ $$| $$|  $$$$$$$| $$_____ | $$$$$$\\       | $$__| $$|  $$$$$$$| $$_____ | $$$$$$\\ 
| $$    $$| $$ \\$$    $$ \\$$     \\| $$  \\$$\\       \\$$    $$ \\$$    $$ \\$$     \\| $$  \\$$\\
 \\$$$$$$$  \\$$  \\$$$$$$$  \\$$$$$$$ \\$$   \\$$        \\$$$$$$   \\$$$$$$$  \\$$$$$$$ \\$$   \\$$
                 "
puts
puts 'Get up to $1000 to win the game'
puts
puts 'Number of decks: 1'
puts

game = Game.new

until game.end?
	puts
	puts '===================='
	puts "|| Bankroll: $ #{game.display_money} ||"
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

	if game.valid_bet?(bet)
		puts
		puts "Your hand: "
		 "#{game.display}"
		puts ">Sum: #{game.user_sum}"
		puts
		puts "Dealer's card: #{game.display_dealer}"
		puts
		game.dealer_sum

		if game.blackjack_draw?
			puts "PUSH: Both you and the dealer got blackjacks"
			puts
			game.new_hand
		else
			if game.user_blackjack?
				puts "WIN: You got a blackjack!"
				game.blackjack_bet_win(bet)
				game.new_hand

			elsif game.dealer_blackjack?
				puts "LOSE: The dealer got a blackjack"
				game.blackjack_bet_lose(bet)
				game.new_hand
			else
				loop do
					print "Hit (H) or Stand (ST)?: "
					move = gets.chomp

					case move
						when 'H'
							puts '-----------'
							puts ">>> HIT <<<"
							puts '-----------'
							puts
							game.hit_user
							game.user_sum
		 					puts
							if game.bust?
		 						puts
								puts "BUST"
								puts
								game.bet_lose(bet)
								game.new_hand
								break
							else
								puts "Your hand: "
								 "#{game.display}"
								puts ">Sum: #{game.user_sum}"
								puts
								puts "Dealer's card: #{game.display_dealer}"
								puts
								if game.dealer_sum < 17
									game.hit_dealer
								end
							end											

						when 'ST'
							puts '-------------'
							puts ">>> STAND <<<"
							puts '-------------'

							while game.dealer_sum < 17
								game.hit_dealer
							end

							game.user_sum
							game.dealer_sum

							if game.draw?
								puts "PUSH"
								puts
								game.new_hand
							else
								if game.win?
									puts "WIN"
									game.bet_win(bet)
									puts
									game.new_hand
									puts
								else
									puts "LOSE"
									puts
									game.bet_lose(bet)
									game.new_hand
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
		puts "Please bet $#{game.display_money} or lower"
		puts
	end

end












