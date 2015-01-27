# IN PROGRESS
# GAME CLASS
# controller connect models and views


#game status: null, win, lost, push, bj
# this is shown in show.erb


# get data
class Game
	def self.all
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		games = mysql.query "SELECT * FROM games ORDER BY id DESC"
		game_objs =[]

		games.each do |game|
			game_objs << Game.new(game['id']) #, game['name'], game['money'])
		end

		game_objs
	end

	def self.all_for_user(user_id)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		games = mysql.query "SELECT * FROM games WHERE user_id = '#{user_id}"
		game_objs =[]

		games.each do |game|
			game_objs << Game.new(game['id']) #, game['name'], game['money'])
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
		@user_hand, @dealer_hand, @shuffled_deck = [], [], []

		game_info = mysql.query("SELECT money, name, status, bet FROM games WHERE id = #{id}").first
		@money, @name, @status, @bet = game_info['money'], game_info['name'], game_info['status'], game_info['bet']

		# put cards into different hands and decks

		db_cards = mysql.query("SELECT * FROM game_cards WHERE game_id = #{id}")
		db_cards.each{|card_info|
			card = Card.new(card_info['suit'], card_info['face'])
			pile = card_info['pile']
			if pile == 'user_hand'
				@user_hand << card
			elsif pile == 'dealer_hand'
				@dealer_hand << card
			else
				@shuffled_deck << card
			end
		}

		#if no cards, create default deck
		if @shuffled_deck.empty? && @user_hand.empty?
			@shuffled_deck = Card.deck.shuffle
			# @shuffled_deck.each{|card|
			# 	puts card.display
			# }
			2.times do
				@user_hand << @shuffled_deck.pop
				@dealer_hand << @shuffled_deck.pop
			end
			@status = 'round_in_progress'
		end
		@money = mysql.query("SELECT * FROM games WHERE id = #{@id}").first['money']	

		self.save

		# puts @mysql.query("SELECT * FROM games WHERE id = #{@id}").to_a
	end

	def self.create(name)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		mysql.query "INSERT INTO games (name, money) VALUES ('#{name}', 100)"

		id = mysql.query("SELECT LAST_INSERT_ID() AS id").first['id']

		Game.new(id)
	end

	


	def name
		@name
	end

	def user_hand
		@user_hand
	end

	def dealer_hand
		@dealer_hand
	end

	def shuffled_deck
		@shuffled_deck
	end

	def user_sum
		summation(@user_hand)
	end

	def dealer_sum
		summation(@dealer_hand)
	end

	def id
		@id
	end

	def money
		@money
	end

	def status
		@status
	end



	def hit_user
		check_shuffled_deck
		
		@user_hand << @shuffled_deck.pop
		
		@user_sum = user_sum

		if @user_sum == 21
			round_won
		elsif @user_sum > 21
			round_lost
		elsif @user_sum < 21
			@status = 'round_in_progress'
		end

		save
	end

	def summation(hand)
		sum = 0
		hand.each {|card|
			sum += card.value
		}

		if sum > 21
			num_ace = hand.count{|card|
				card.face == 'A'
			}
			sum -= num_ace * 10 		
		end

		sum
	end

	def round_won
		@status = 'round_won'
		if user_sum == 21 && @user_hand.count == 2
			@status = 'round_blackjack'
			@money += @bet * 1.5
		end
		@money += @bet

		save
	end

	def round_lost
		@status = 'round_lost'

		@money -= @bet
		save
	end

	def stand
		check_shuffled_deck

		@dealer_sum = summation(@dealer_hand)

		while @dealer_sum < 17
			@dealer_hand << @shuffled_deck.pop
			@dealer_sum = summation(@dealer_hand)
		end

		if @dealer_sum > 21
			@status = 'round_won'
		elsif user_sum == @dealer_sum
			@status = 'round_draw'
		elsif user_sum < @dealer_sum
			round_lost
		elsif user_sum > @dealer_sum
			round_won
		end

		save
	end

	def check_shuffled_deck
		if @shuffled_deck.count < 4
			@shuffled_deck << Card.deck.shuffle
		end
	end

	def new_round
		check_shuffled_deck

		@user_hand.clear
		@dealer_hand.clear

		2.times do
			@user_hand << @shuffled_deck.pop
			@dealer_hand << @shuffled_deck.pop
		end

		@status = 'new_round'
		save 	# so why can you just say 'save' instead of 'self.save???'
	end

	def check_bet(bet)
		valid_bet = nil

		check = bet.to_i

		if check > 0
			if check > @money
				valid_bet = false
			else
				valid_bet = true
			end
		else
			valid_bet = false
		end

		return valid_bet
	end

	def place_bet(bet)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		if check_bet(bet)
			@bet = bet.to_i
			mysql.query "UPDATE games SET bet = #{@bet} WHERE id = #{@id}"
			true
		else
			false
		end
		# puts query		
		# mysql.query query
	end

	def save
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		mysql.query "UPDATE games SET money = #{@money}, status = '#{@status}', bet = #{@bet} WHERE id = #{@id} "

		mysql.query "DELETE FROM game_cards WHERE game_id = #{@id}"
		
		@user_hand.each{|card|
				mysql.query "INSERT INTO game_cards(face, suit, game_id, pile)
					VALUES('#{card.face}', '#{card.suit}', #{@id}, 'user_hand')"
			}
		
		@dealer_hand.each{|card|
				mysql.query "INSERT INTO game_cards(face, suit, game_id, pile)
					VALUES('#{card.face}', '#{card.suit}', #{@id}, 'dealer_hand')"
			}
		@shuffled_deck.each{|card|
				mysql.query "INSERT INTO game_cards(face, suit, game_id, pile)
					VALUES('#{card.face}', '#{card.suit}', #{@id}, 'shuffled_deck')"
			}
	end






	
end