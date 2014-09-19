# IN PROGRESS
# WORK ON:
# - Create Interface (Graphics) for the game
# - Give hints to user for moves
# - Enable user to save and exit the game
# - Add Split, Double, Insurance Features
#Blackjack Game

require_relative 'game'
require_relative 'card'

require 'mysql2'
mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'Blackjack')



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


command = nil
until command == 'e'
	puts "Would you like to (c)reate a new game, (l)list all games, (s)earch for a game, or (e)xit?"
	command = gets.strip
	
	case command
		when 'c'
			puts "Please enter a name for your game"
			game_name = gets.strip
			safe_name = mysql.escape(game_name)

			mysql.query "INSERT INTO games (name) VALUES ('#{safe_name}')"
			puts "Game created!"

			puts "______________________________________________"
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
								print "(h)it or (st)and?: "
								move = gets.chomp

								case move
									when 'h'
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

									when 'st'
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

		when 'l'
			puts 'Listing all games, most recent first'
			games = mysql.query "SELECT * FROM games ORDER BY id DESC"

			games.each do |game|
			  puts "#{game['id']}:  #{game['name']}"
			end

			puts
			puts "Enter ID of the game to load: "
			loading_game = gets.to_i
			

		when 's'
			puts "Type the name of a particular game you'd like to see:"
			game_name = gets.strip 	#OOPS I'M NOT ESCAPING THIS - BAD NEWS

			result = mysql.query "SELECT * FROM games WHERE name = '#{game_name}'"

			if result.count > 0
				game = result.first 
				puts "We found that game! Here's it's info:"
				puts "#{game['id']}:  #{game['name']}"
			else
				puts "Oops we couldn't find a game with that name!"
			end
		when 'e'
			abort "Thanks for playing!"
			puts
			puts
		else
			puts "Invalid command!"
	end
end


















