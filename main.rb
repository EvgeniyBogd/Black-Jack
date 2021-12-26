require_relative 'deck'
require_relative 'dealer'
require_relative 'player'
require_relative 'game'

class Main

  MENU  = "
    1. Пропустить ход.
    2. Добавить карту (максимум 3 карты).
    3. Открыть карты.
  "

  def start_game
    puts "Начнем игру!"
    puts "Введите свое имя"
    name = gets.chomp.to_s
    player = Player.new(name)
    dealer = Dealer.new
    @game = Game.new(player,dealer)
    puts "Делаем ставку"
    @game.bets
    puts "В банке #{@game.bank}"
    puts "Раздаем карты"
    @game.deal_cards
    puts "Карты диллера **"
    puts "Карты игрока - #{player.hand_card}"
    @game.cards_value
    puts "Ваши очки - #{player.hand_value}"
    action
  end

  def action
    puts MENU
    action = gets.chomp.to_i
    case action
    when 1
      @game.dealer_action
    when 2
      @game.player_action
      raise " Карт может быть только 3"
    when 3
      puts "#{dealer.show_hand_card}"
      puts "#{player.show_hand_card}"
    end
  end

end
Main.new.start_game
