class Card 		# Keeps tract of a single card
	def self.deck 				# class is in world of forms, objects under
		suits_array = ['Heart', 'Spade', 'Diamond', 'Club']
		faces_array = ['A', 2,3,4,5,6,7,8,9,10, 'J', 'Q', 'K']
		deck = []

		suits_array.each{|suit|
			faces_array.each{|face|
				deck << Card.new(suit, face)
			}
		}
		deck
	end


	def initialize(suit, face)
		@face = face
		@suit = suit
	end

	
	def value
		value = 0
		if @face  == 'J' || @face == 'Q' || @face == 'K'
			value = 10
		elsif @face == 'A'
			value = 11
		else
			value = @face.to_i
		end
	end

	def display
		"#{@suit}-#{@face}"
	end

	def filename
		"#{@suit.chars.first}_#{@face}.png"
	end
	
	def graphics(card)
		if card.suit == "Club"
" .-------.       
 |   _   |   
 | _( )_ |  
 |(_ . _)|    
 |   I   |   
 |   #{@face}   |     
 '-------'"  
		elsif card.suit == "Diamond"
" .-------.  
 |  / \\  |  
 | /   \\ |  
 | \\   / |  
 |  \\ /  |  
 |   #{@face}   |  
 '-------' "
		elsif card.suit == "Spade"
" .-------.  
 |   *   |  
 | *   * |  
 |*     *|  
 |  *I*  |  
 |   #{@face}   |  
 '-------' "
		elsif card.suit == "Heart"
" .-------.  
 | ** ** |  
 |*  *  *|  
 | *   * |  
 |   *   |  
 |   #{@face}   |  
 '-------'"
		end
	end


	def ==(another_card)
		@face == another_card.face && @suit == another_card.suit
	end

	def face
		@face
	end

	def suit
		@suit
	end

	def file_name
		"#{@suit.chars.first}_#{@face}"
	end

end




