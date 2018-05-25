require 'pry'
require 'pry-byebug'

class Player

  attr_reader :cards, :name

  def initialize(name)
    @name = name
    @cards = []
  end

  def hit(deck)
    cards << deck.peel
    puts "#{name} got #{cards.last}"
  end

  def stand
    puts "#{name} stands. Cards total is #{total}."
  end

  def busted?
    total > 21
  end

  def total
    cards.reduce(0) do |memo, card|
      memo + card.value
    end
  end
end

class Deck

  RANKS = %w[2 3 4 5 6 7 8 9 10 jack queen king ace]
  SUITS = %w[hearts clubs diamonds spades]
  TEMPLATE = RANKS.product(SUITS)

  attr_reader :cards
  
  def initialize
    @cards = TEMPLATE.map do |rank_suit|
      Card.new(rank_suit.first, rank_suit.last)
    end
  end

  def shuffle
    cards.shuffle!
  end

  def deal(punter, dealer)
    shuffle
    punter.cards << cards.shift
    dealer.cards << cards.shift
    punter.cards << cards.shift
    dealer.cards << cards.shift
  end

  def peel
    cards.shift
  end
end

class Card
  attr_reader :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = determine_value
  end

  def determine_value
    if @rank == 'ace'
      11
    elsif @rank.to_i == 0
      10
    else
      @rank.to_i
    end
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

class Game
  attr_reader :punter, :dealer, :deck

  def initialize
    @punter = Player.new('Punter')
    @dealer = Player.new('Dealer')
    @deck = Deck.new
  end

  def clear
    system('clear') || system('cls')
  end

  def display_welcome
    clear
    puts "Hi it's 21 you know the rules... (dealer stands on soft 17 btw!)"
    puts "Let's play! Dealing cards..."
    puts ""
  end

  # refactor because getting nested...
  def display_initial_cards
    puts "#{punter.name} has #{punter.cards.first} and #{punter.cards.last}."
    puts "#{dealer.name} has #{dealer.cards.first} and ...?"
  end

  def reveal_second_dealer_card
    puts "Alongside the #{dealer.cards.first}, #{dealer.name} flips a #{dealer.cards.last}"
  end

  def punter_turn(deck)
    choice = ''

    until choice == 's' || punter.busted?
      loop do
        puts "Hit ('h') or stand ('s')?"
        choice = gets.chomp.downcase
        break if %w[h s].include?(choice)
        puts "Invalid choice. Try again."
      end
      
      choice == 'h' ? punter.hit(deck) : punter.stand
    end
    
    puts "With a total of #{punter.total}, #{punter.name} busted!" if punter.busted?
  end

  def dealer_turn(deck)
    reveal_second_dealer_card
    dealer.hit(deck) until dealer.total >= 17 || dealer.busted?
  end

  def play
    display_welcome
    deck.deal(punter, dealer)
    display_initial_cards
    punter_turn(deck)
    dealer_turn(deck)
    # show_result
    # play_again?
  end
end

Game.new.play
