require_relative 'dealer'
require_relative 'bank'

min = Dealer.new
@player_bank = Bank.new
@dealer_bank = Bank.new

def messenge(sms)
  puts "#{sms}"
end

def show_balance
  puts "Ваш баланс: #{@player_bank.balance}"
  puts "Баланс Диллера: #{@dealer_bank.balance}"
end

show_balance
messenge("Welcome to our casino")
sleep 1
messenge("The game of Black Jack begins")
sleep 1
messenge("Представьтесь пожалуйста!")
name_player = gets.chomp
messenge("Рады вас приветствовать #{name_player}!!!")
messenge("У вас в Банке #{@player_bank.balance}")
item = 1
loop do
  case item
  when 1
    messenge("Карту!____________________________________")
    min.distribute("player")
    min.distribute("dealer")
    min.show_cards
    item += 1
    sleep 1
  when 2
    messenge("Ещё карту!____________________________________")
    min.distribute("player")
    min.distribute("dealer")
    min.show_cards
    messenge("Делайте ставки Гаспода!")
    @player_bank.make_bet
    @dealer_bank.make_bet
    sleep 2
    messenge("Ставки сделаны!")
    sleep 2
    messenge("____________________________________")
    show_balance
    min.player_choice
    item = gets.chomp.to_i
  when 3  # Пропустить_ход игроку
    messenge("Вы пропускаете ход ____________________________________")
    min.distribute("dealer") if min.sum_cards_dealer < 17
    item += 2
  when 4  # Добавить_карту
    messenge("Ещё карту!____________________________________")
    min.distribute("player")
    min.distribute("dealer") if min.sum_cards_dealer < 17
    item += 1
  when 5  # открыть карты
    messenge("Открываем карты____________________________________")
    min.open_cards
    if min.who_won == '1'
      @player_bank.win_bet
      messenge("Победил #{name_player}!!!")
      messenge("Ваш баланс #{@player_bank.balance}")
    elsif min.who_won == '-1'
      @dealer_bank.win_bet
      messenge("Победил Диллер!!")
      messenge("Баланс #{@dealer_bank.balance}")
    elsif min.who_won == '0'
      @player_bank.return_bet
      @dealer_bank.return_bet
      messenge("Ничья")
      show_balance
    end
    sleep 2
    messenge("____________________________________")
    messenge("Для выхода из Казино Введите 'end' ")
    messenge("Хотите продолжить Игру? Введите '6' ")
    show_balance
    item = gets.chomp.to_i
    break if @dealer_bank.balance == 0 || @player_bank.balance == 0 || item == "end".to_i
  when 6
    messenge("____________________________________")
    min.delete_deck_cards
    item = 1
  end
end

