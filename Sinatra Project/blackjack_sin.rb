# IN PROGRESS
# Sinatra & Blackjack

# links working on the index page
# display basic information about the chosen game on another page 
# (using the game data you already have in your databases - don’t worry about creating new games at this point).
# Bonus points for showing images of the current game's cards (served from your public folder).

# add link to index page
# create new page for new game
# HTML A tag

# Read HTML Form


		# <% game_name = gets.strip 
		# save_name = mysql.escape(game_name)

		# mysql.query "INSERT INTO games (name, money) VALUES ('#{save_name}', 100)"
		
		# id = mysql.query("SELECT LAST_INSERT_ID() AS id").first['id'] %>


require 'mysql2'

require 'sinatra'
require_relative "models/game.rb"
require_relative "models/card.rb"

# Add a sum method to the Array class
# class Array
#   def sum
#     sum = 0
#     self.each do |num|
#       sum += num
#     end
#     return sum
#   end
# end


get '/hi' do
  "Hello World!"
end

get '/' do
	@game = Game.all
	erb :index
end

get '/games/new' do 			# catch before inserting ID
	erb :new
end
	
post '/games/create' do
	@game = Game.create(params[:user])
	redirect "/games/#{@game.id}"
end

get '/games/:game_id' do  			# Sinatra's params
	@game = Game.new(params[:game_id])
	@game.find(params[:game_id])
	
	erb :show
end

get '/games/:game_id/hit' do
	@game = Game.new(params[:game_id])
	@game.hit_user
	redirect "/games/#{@game.id}"
end


get '/games/:game_id/stand' do
	@game = Game.new(params[:game_id])
	@game.stand
	redirect "/games/#{@game.id}"
end

get '/games/:game_id/new_round' do
	@game = Game.new(params[:game_id])
	@game.new_round
	redirect "/games/#{@game.id}/bet"
end

get '/games/:game_id/bet' do 			# "post" means getting info from the user
	@game = Game.new(params[:game_id])
	erb :bet
end

post '/games/:game_id/place_bet' do
	@game = Game.new(params[:game_id])
	@game.place_bet(params[:bet])
	# erb :debug
	redirect "/games/#{@game.id}"
end


# get '/public' do

# end