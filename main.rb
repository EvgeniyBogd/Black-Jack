require_relative 'deck'
require_relative 'dealer'
require_relative 'player'
require_relative 'game'

class Main

  def pre_game
    puts "Начнем игру!"
    sleep(1)
    puts "Введите свое имя"
    @name = gets.chomp.to_s
    @player = Player.new(@name)
    @dealer = Dealer.new
    @game = Game.new(@player,@dealer)
    start_game
  end

  def start_game
    puts "Делаем ставки..."
    @game.bets
    sleep(1)
    puts "В банке #{@game.bank}"
    sleep(1)
    puts "Раздаем карты..."
    @game.deal_cards
    sleep(1)
    puts "Карты диллера **"
    sleep(1)
    puts "Карты игрока:"
    @player.hand_card
    sleep(1)
    puts "Ваши очки - #{@player.hand_value}"
    action
  end

  def action
      self.case_action
      puts "Определяем победителя"
      sleep(1)
      puts "Карты игрока:"
      @player.hand_card
      puts "Карты диллера:"
      @dealer.hand_card
      sleep(1)
      @game.winner_game
      puts "Распределяем призовые"
      sleep(1)
      @game.take_bank
      puts "Игрок #{@player.bankroll}"
      puts "Диллер #{@dealer.bankroll}"
      sleep(1)
      self.continue
  end

  def case_action
    loop do
    @step = 0
    puts "1. Пропустить ход" if @step < 2
    puts "2. Взять карту" if @player.hand.size < 3
    puts "3. Открыть карты "
    @action = gets.chomp.to_i
    case @action
    when 1
      @game.dealer_action
      @step +=1
    when 2
      @game.player_action
      @player.hand_card
      puts "Ваши очки - #{@player.hand_value}"
    when 3
      @game.dealer_action
      sleep(1)
      @dealer.hand_card
      @player.hand_card
    end
    break if  @action == 3 || @player.hand.size == 3 &&
      @dealer.hand.size == 3
    end
  end

  def continue
    puts "Играем еще?(y/n)"
    answer = gets.chomp.downcase.to_s
    if answer == "y"
      @game.reset
      self.start_game
    else
      exit
    end
  end



end
Main.new.pre_game
