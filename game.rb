require_relative 'player'
require_relative 'dealer'


class Game

  attr_reader :bank, :player, :dealer, :winner

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
    player.value_hand
  end

  def dealer_action
    dealer.value_hand
    if dealer.hand_value < 17 && dealer.hand.size < 3
      dealer.take_card!(@deck)
      puts "Диллер взял еще карту"
    else
      puts "Диллер не берет карту"
    end
  end

  def player_action
    if player.hand.size < 3
      player.take_card!(@deck)
    else
      puts "У вас максимальное количество карт"
    end
    player.value_hand
  end

  def winner_case
    dealer.value_hand
    player.value_hand
    if player.hand_value > dealer.hand_value && player.hand_value <= 21
      @winner = "player"
    elsif player.hand_value == 21 && dealer.hand_value != 21
      @winner = "player"
    elsif  dealer.hand_value > 21 && player.hand_value < 21
      @winner = "player"
    elsif player.hand_value == dealer.hand_value
      @winner = "nobody"
    elsif player.hand_value > 21 && dealer.hand_value > 21
      @winner = "nobody"
    else
      @winner = "dealer"
    end
    @winner
  end

  def winner_game
    winner_case
    if @winner == "player"
      puts "Победил  #{player.name} #{player.hand_value}"
    elsif @winner == "nobody"
      puts "Ничья"
    else
      puts "Победило казино #{dealer.hand_value}"
    end
  end

  def take_bank
    case winner
    when "player"
        player.bankroll += bank
    when "nobody"
        player.bankroll += bank/2
        dealer.bankroll += bank/2
    when "dealer"
        dealer.bankroll += bank
    end
  end

  def reset
    @deck.cards += player.hand
    @deck.cards += dealer.hand
    player.hand = []
    dealer.hand = []
    @deck.cards.shuffle!
  end

  def three_card
    if player.hand.size == 3 && dealer.hand.size == 3
      true
    else
      false
    end
  end
end
