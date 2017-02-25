# User class

class User

	def self.find(user_id, password)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		user = mysql.query("SELECT * FROM user WHERE user_id = '#{user_id}' AND password = '#{password}' ").first

		@duplicate = false
		if user != nil
			User.new(user['id'], user['user_id'], user['password'])
		else
			nil
		end
	end

	def initialize(id, user_id, password)
		@id, @user_id, @password = id, user_id, password
	end

	def self.new_user(user_id, password)
		mysql = Mysql2::Client.new(host: '127.0.0.1', username: 'root', database: 'blackjack')

		@duplicate = nil

		duplicate_user = mysql.query("SELECT * FROM user WHERE user_id = '#{user_id}'").first
		if duplicate_user != nil
			@duplicate = true
		else
			@duplicate = false
			mysql.query "INSERT INTO user (user_id, password) VALUES ('#{user_id}', '#{password}')"
		end
	end


	def id
		@id
	end

	def duplicate
		return @duplicate
	end

	def username
		@username
	end

end