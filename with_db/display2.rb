
class Display < Game
	def display
		@user_hand.each{|card|
			puts card.display
		}
	end

	def display_dealer
		@dealer_hand[0].display
	end

	def reveal_dealer
		@dealer_hand.each{|card|
			puts card.display
		}
	end

	def display_money
		@user_money
	end
end