require_relative 'deck'
require_relative 'card'

class User

  attr_accessor :bankroll, :hand, :bet
  attr_reader :hand_value

  def initialize(name)
    @name = name.to_s
    @hand = []
    @hand_value = 0
    @bankroll = 100
    @bet = 0
  end

  def take_card!(deck)
    hand << deck.cards.shift
  end

  def value_hand
    @hand.each do |card|
      if card.face == "A" && @hand_value > 10
        @hand_value += 1
      else
        @hand_value += card.value
      end
        @hand_value
      end
  end

  def add_to_bank
    @bet = 10
    @bankroll -= @bet
  end

  def hand_card
    @hand.each_with_index do |card, index|
    puts  "#{index + 1}: #{card.face}#{card.suit}"
    end
  end

end
