# IN PROGRESS
# WORK ON:
# - Create Interface (Graphics) for the game
# - Give hints to user for moves
# - Enable user to save and exit the game
# - Add Split, Double, Insurance Features
#Blackjack Game

require_relative 'game_new'
require_relative 'card'

require 'mysql2'
mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')



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
	print "Would you like to (c)reate a new game, (l)list all games, (s)earch for a game, or (e)xit?"
	command = gets.strip
	
	case command
		when 'c'
			puts "Please enter a name for your game"
			game_name = gets.strip
			save_name = mysql.escape(game_name)

			mysql.query "INSERT INTO games (name, money) VALUES ('#{save_name}', 100)"
			
			id = mysql.query("SELECT LAST_INSERT_ID() AS id").first['id']
			puts id

			puts "Game created!"

			puts "______________________________________________"
			puts "#{save_name}'s Blackjack Game"
			puts
			puts 'Get up to $1000 to win the game'
			puts
			puts 'Number of decks: 1'
			puts

			game = Game.new(id)
			game.run
			

		when 'l'
			puts 'Listing all games, most recent first'
			games = mysql.query "SELECT * FROM games ORDER BY id DESC"

			games.each do |game|
			  puts "#{game['id']}:  #{game['name']}"
			end

			puts
			puts "Enter ID of the game to load: "
			loading_game_id = gets.to_i

			game = Game.new(loading_game_id)
			game.run
				# mysql.query "SELECT * FROM game_cards WHERE game_id = #{loading_game_id}")

			# games.each do |game|
			#   puts "#{game['id']}:  #{game['name']}"
			# end		


		when 's'
			puts "Type the name of a particular game you'd like to see:"
			game_name = gets.strip 	#OOPS I'M NOT ESCAPING THIS - BAD NEWS

			result = mysql.query "SELECT * FROM games WHERE name LIKE '#{game_name}%'"

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


















