class Dealer
  attr_accessor :sum_cards_player, :sum_cards_dealer
 
  def  initialize
    @deck_cards_number = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'] 
    @deck_cards_suits = ['♦', '♠', '♥', '♣']      # Буби, Черви, Пики, Крести
    @choice_options = %w(Пропустить_ход Добавить_карту Открыть_карты)
    @deck_cards_dealer = []
    @deck_cards_player = []
    @sum_cards_dealer = 0
    @sum_cards_player = 0
  end

# раздаём карты игроку и диллеру
  def distribute(name)
    if "player" == name 
      value = @deck_cards_number.sample
      @sum_cards_player = total(@sum_cards_player, value)
      @deck_cards_player << "#{value}_#{@deck_cards_suits.sample}"
    elsif "dealer" == name
      value = @deck_cards_number.sample
      @sum_cards_dealer =  total(@sum_cards_dealer, value)
      @deck_cards_dealer << "#{value}_#{@deck_cards_suits.sample}"
    end
  end

# считаем сумму карты на руках 
  def total(sum_cards_name, value)
    ten = %w(J Q K)

    if ten.include?(value) 
      sum_cards_name += 10
    elsif (value == "A") && (sum_cards_name < 17)
      sum_cards_name += 10  
    elsif (value == "A") && (sum_cards_name > 17)
      sum_cards_name += 1 
    else 
      sum_cards_name += value.to_i
    end
    return sum_cards_name.to_i
  end

  def player_choice
    @choice_options.each_with_index{ | choice, row | puts "#{row + 3}. #{choice}"}
  end

  def show_cards
    puts "Ваши карты:    #{@deck_cards_player}. Сумма Карт: #{@sum_cards_player}"
    puts "Карта Диллера: #{closed_cards}"
  end

  def closed_cards
    return arr = Array.new(@deck_cards_dealer.size, "*")
  end

  def open_cards
    puts "Ваши карты:    #{@deck_cards_player}. Сумма Карт: #{@sum_cards_player}"
    puts "Карта Диллера: #{@deck_cards_dealer}. Сумма Карт: #{@sum_cards_dealer}"
  end

  def delete_deck_cards
    @deck_cards_dealer.clear
    @deck_cards_player.clear
    @sum_cards_dealer = 0
    @sum_cards_player = 0
  end

  def who_won
    if @sum_cards_player == @sum_cards_dealer
      return '0'
    elsif (@sum_cards_player < @sum_cards_dealer) && ((@sum_cards_player <= 21) && (@sum_cards_dealer > 21))
      return '1'   # выйграл игрок
    else
      return '-1'  # выйграл диллер
    end
  end
end
