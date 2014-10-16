# IN PROGRESS
# GAME CLASS
# controller connect models and views



# get data
class Gameclass
	def self.all
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		games = mysql.query "SELECT * FROM games ORDER BY id DESC"
		game_objs =[]

		games.each do |game|
			game_objs << Gameclass.new(game['id']) #, game['name'], game['money'])
		end

		game_objs
	end

	# Find method: new data tables (pile- user hand, dealer hand, etc) from mysql


	def find(id)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')
		# find = mysql.query("SELECT * FROM games WHERE id = #{id}")
		# puts find
		query = "SELECT * FROM games WHERE id = #{id}"
		puts query
		# abort query
	end

	def initialize(id)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')
		# get money, name, ID
		@id = id
		# @money, @name = mysql.query("SELECT money, name FROM games WHERE id = #{id}").first
		game_info = mysql.query("SELECT money, name FROM games WHERE id = #{id}").first
		@money, @name = game_info['money'], game_info['name']

		# put cards into different hands and decks
		@user_hand, @dealer_hand, @shuffled_deck = [], [], []

		card = mysql.query("SELECT suit, face FROM game_cards WHERE id = #{id}")
		puts card

		# name = mysql.query "SELECT name FROM games WHERE id = #{id}"
		# @name = name

		# abort money
		# list = {}
		# games = mysql.query "SELECT * FROM games ORDER BY id DESC"

		# games.each do |game|
		# "#{game['id']}:  #{game['name']}"
		# end


		# command = nil
		# until command == 'e'
		#   print "Would you like to (c)reate a new game, (l)list all games, (s)earch for a game, or (e)xit?"
		#   command = gets.strip
		  
		#   case command
		#     when 'c'
		#       puts "Please enter a name for your game"
		#       game_name = gets.strip
		#       save_name = mysql.escape(game_name)

		#       mysql.query "INSERT INTO games (name, money) VALUES ('#{save_name}', 100)"
		      
		#       id = mysql.query("SELECT LAST_INSERT_ID() AS id").first['id']
		#       puts id

		#       puts "Game created!"

		#       puts "______________________________________________"
		#       puts "#{save_name}'s Blackjack Game"
		#       puts
		#       puts 'Get up to $1000 to win the game'
		#       puts
		#       puts 'Number of decks: 1'
		#       puts

		#       game = Game.new(id)
		#       game.run
		      

		#     when 'l'
		

		#       puts
		#       puts "Enter ID of the game to load: "
		#       loading_game_id = gets.to_i

		#       game = Game.new(loading_game_id)
		#       game.run
		#         # mysql.query "SELECT * FROM game_cards WHERE game_id = #{loading_game_id}")

		#       # games.each do |game|
		#       #   puts "#{game['id']}:  #{game['name']}"
		#       # end   


		#     when 's'
		#       puts "Type the name of a particular game you'd like to see:"
		#       game_name = gets.strip  #OOPS I'M NOT ESCAPING THIS - BAD NEWS

		#       result = mysql.query "SELECT * FROM games WHERE name LIKE '#{game_name}%'"

		#       if result.count > 0
		#         game = result.first 
		#         puts "We found that game! Here's it's info:"
		#         puts "#{game['id']}:  #{game['name']}"
		#       else
		#         puts "Oops we couldn't find a game with that name!"
		#       end
		#     when 'e'
		#       abort "Thanks for playing!"
		#       puts
		#       puts
		#     else
		#       puts "Invalid command!"
		#   end
		# end
	end

	def name
		@name
	end

	def user_hand
		@user_hand
	end

	def id
		@id
	end

	def money
		@money
	end
	
end