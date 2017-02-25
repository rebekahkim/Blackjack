# IN PROGRESS
# Sinatra & Blackjack

# display basic information about the chosen game on another page 

# Read HTML Form

		# <% game_name = gets.strip 
		# save_name = mysql.escape(game_name)

		# mysql.query "INSERT INTO games (name, money) VALUES ('#{save_name}', 100)"
		
		# id = mysql.query("SELECT LAST_INSERT_ID() AS id").first['id'] %>


require 'mysql2'
# enable :sessions
require 'sinatra'
require_relative "models/game.rb"
require_relative "models/card.rb"
require_relative "models/user.rb"


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
	if ! session[:user_id]
		erb :home
	else
		@games = Game.all_for_user(session[:user_id])
		erb :index
	end
end

def authenticate
	game = Game.new(params[:game_id])
	if session[:user_id] != game.id
		redirect '/'
	end

	# use LoginScreen

	before do
		unless session[:user_id]
			halt "Access denied, please <a href='/login'>login</a>."
		end
	end

	get('/') { "Hello #{session['user_id']}." }
end


before '/games/:game_id' do
	if params[:game_id].is_a? Integer
		authenticate
	end
end

before '/games/:game_id/*' do
  authenticate
end

post '/login' do
	user = User.find(params[:user_id], params[:password])
	if user
		session[:user_id] = user.id
		redirect "/"
	else
		erb :login
	end
end

get '/register' do
	erb :register
end

post '/new_user'do
	user = User.new_user(params[:user_id], params[:password])

	if user.duplicate == true
		@duplicate_message = true
		erb :login
	else
		redirect '/'
	end
end


get '/games/new' do 			# catch before inserting ID
	erb :new
end
	
post '/games/create' do 									# DONT ALLOW SQL INJECTION!!!
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

# get '/betting_error' do
# 	erb :error
# end

post '/games/:game_id/place_bet' do
	@game = Game.new(params[:game_id])
	if @game.place_bet(params[:bet])
		redirect "/games/#{@game.id}"
	else
		@error_message = true
		erb :bet
	end	
	# erb :debug
end


# get '/public' do

# end