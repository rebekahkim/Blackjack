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


require 'mysql2'

require 'sinatra'
require_relative "models/game.rb"



get '/hi' do
  "Hello World!"
end

# get '/index' do
# 	"GAME INDEX"
# end

get '/' do
	@game = Game.all
	erb :index
end

get '/games/:game_id' do
	@game = Game.new(params[:game_id])
	@game.find(params[:game_id])
	
	erb :show
end

# get '/public' do

# end