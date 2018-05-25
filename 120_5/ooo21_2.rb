class Player
  attr_accessor :cards, :score
  attr_reader :name

  def initialize(name)
    @name = name
    @cards = []
    @score = 0
  end

  def show_cards(reveal = 'all')
    if reveal == 'all'
      cards.join(', ')
    else
      cards[reveal - 1]
    end
  end

  def hit(deck)
    cards << deck.peel_card
    hit_output
  end

  def busted?
    total > 21
  end

  def turn_outcome
    busted? ? "#{name} busts with #{total}." : "#{name} stands on #{total}."
  end

  def total
    aces = cards.count { |card| card.rank == 'ace' }

    aces > 0 ? acey_total(aces) : standard_total
  end

  private

  def hit_output
    puts "HIT: #{cards.last}"
    puts "Current cards: #{show_cards}" unless name == 'Dealer' || busted?
  end

  def standard_total
    cards.reduce(0) { |memo, card| memo + card.value }
  end

  def acey_total(aces)
    return standard_total if standard_total <= 21
    acey_total = standard_total

    until acey_total <= 21 || aces < 1
      acey_total -= 10
      aces -= 1
    end

    acey_total
  end
end

class Deck
  RANKS = %w[2 3 4 5 6 7 8 9 10 jack queen king ace]
  SUITS = %w[hearts clubs diamonds spades]
  TEMPLATE = RANKS.product(SUITS)

  # attr_reader :cards

  def initialize
    @cards = TEMPLATE.map do |rank_suit|
      Card.new(rank_suit.first, rank_suit.last)
    end
  end

  def deal_initial_cards(punter, dealer)
    shuffle
    2.times do 
      punter.cards << peel_card
      dealer.cards << peel_card
    end
  end

  def peel_card
    @cards.shift
  end

  private

  def shuffle
    @cards.shuffle!
  end
end

class Card
  attr_reader :value, :rank

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = determine_value
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  private

  def determine_value
    if @rank == 'ace'
      11
    elsif @rank.to_i == 0
      10
    else
      @rank.to_i
    end
  end
end

class Game
  attr_reader :punter, :dealer, :deck

  def initialize
    @punter = Player.new('Punter')
    @dealer = Player.new('Dealer')
    @deck = Deck.new
    @round = 1
    @game_rounds = nil
    @round_winner = nil
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  # only just over on both counts; method is easy enough to follow imo
  def play
    display_welcome
    determine_number_of_rounds
    loop do
      deal
      display_initial_cards
      punter_turn
      display_turn_outcome(punter)
      dealer_turn unless punter.busted?
      calculate_winner
      display_result
      increment_score
      @round += 1
      break if @round > @game_rounds
      reset
    end
    display_overall_winner
    display_goodbye
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  private

  def clear
    system('clear') || system('cls')
  end

  def display_welcome
    clear
    puts "Hi it's 21 you know the rules... (dealer stands on soft 17 btw!)"
    puts "Let's play! Dealing cards..."
    puts "P.S. do your own math ;)"
    puts ""
  end

  def determine_number_of_rounds
    choice = ''
    loop do
      puts "How many rounds do you want to play?"
      choice = gets.chomp
      break if valid_rounds?(choice)
      puts "Please enter digits. Cannot be blank, or 0."
    end

    @game_rounds = choice.to_i

    puts "Ok..."
    sleep 1
    clear
  end

  def valid_rounds?(choice)
    choice =~ /\A\d+\z/ && choice !~ /\A0+\z/
  end

  def deal
    deck.deal_initial_cards(punter, dealer)
  end

  def display_initial_cards
    puts "#{punter.name}: #{punter.show_cards}"
    puts "#{dealer.name}: #{dealer.show_cards(1)}, ...?"
  end

  def dealer_reveals_second_card
    puts "#{dealer.name} flips the #{dealer.show_cards(2)}."
    puts "#{dealer.name}'s cards: #{dealer.show_cards}"
    puts ""
  end

  # rubocop:disable Metrics/AbcSize
  # 18.55... probably not worth assuaging by extracting introductory output
  def punter_turn
    puts ""
    puts "#{punter.name}'s turn..."
    choice = ''

    until choice == 's' || punter.busted?
      loop do
        puts "Hit ('h') or stand ('s')"
        choice = gets.chomp.downcase
        break if ['h', 's'].include?(choice)
        puts "Invalid choice. Try again."
      end

      punter.hit(deck) if choice == 'h'
    end
  end
  # rubocop:enable Metrics/AbcSize

  def dealer_turn
    puts ""
    dealer_reveals_second_card

    until dealer.total >= 17 || dealer.busted?
      dealer.hit(deck)
      sleep 1.25
    end

    display_turn_outcome(dealer)
  end

  def display_turn_outcome(player)
    puts player.turn_outcome
  end

  def calculate_winner
    @round_winner = if punter.busted?
                      -1
                    elsif dealer.busted?
                      1
                    else
                      punter.total <=> dealer.total
                    end
  end

  def display_result
    puts ""
    puts case @round_winner
         when -1 then "#{dealer.name} wins the round!"
         when 1 then "#{punter.name} wins the round!"
         else
           "It's a push!"
         end
  end

  def increment_score
    case @round_winner
    when 1 then  punter.score += 1
    when -1 then dealer.score += 1
    end
  end

  def display_overall_winner
    puts ""
    puts "Final score:"
    puts "#{punter.name}: #{punter.score}, #{dealer.name}: #{dealer.score}"

    puts case punter.score <=> dealer.score
         when -1 then "Hope you have money left for the cab ride home..."
         when 1 then  "Hope you were maxing out your bets!"
         else         "You live to fight another day..."
         end
  end

  def reset
    @deck = Deck.new
    @round_winner = nil
    punter.cards = []
    dealer.cards = []
    puts ""
    puts "Enter to continue"
    gets
    puts "Next round..."
    sleep 2
    clear
  end

  def display_goodbye
    puts ""
    puts "Thanks for playing 21 bye!!"
  end
end

Game.new.play
