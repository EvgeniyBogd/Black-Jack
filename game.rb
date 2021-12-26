require_relative 'player'
require_relative 'dealer'


class Game

  attr_reader :bank, :player, :dealer

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    @deck = Deck.new
    @bank = 0
  end

  def game_bank
    @bank = @player.bet + @dealer.bet
  end

  def bets
    dealer.add_to_bank
    player.add_to_bank
    game_bank
  end

  def deal_cards
    2.times{dealer.take_card!(@deck)}
    2.times{player.take_card!(@deck)}
  end

  def cards_value
    player.value_hand
    dealer.value_hand
  end

  def cards
    player.hand_card
    dealer.hand_card
  end

  def dealer_action
  end

 end
