require_relative 'card'

class Deck

  FACES = [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "D", "K", "A"]
  SUITS = %w[♠, ♥, ♣, ♦]

  attr_accessor :cards

  def initialize
    @cards = []
    create_deck
  end

  def create_deck
      FACES.each do |face|
        if face.class == Integer
          value = face.to_i
        elsif face == "A"
          value = 11
        else
          value = 10
        end
        SUITS.each do |suit|
          @cards << Card.new(face, suit, value)
        end
    end
    @cards.shuffle!
  end
end
