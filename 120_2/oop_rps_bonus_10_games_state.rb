require 'pry'
require 'pry-byebug'
class Move
  VALUES = { 'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock' }

  WINNING_MOVES = {
    'rock' =>     ['scissors', 'lizard'],
    'paper' =>    ['rock', 'spock'],
    'scissors' => ['lizard', 'paper'],
    'spock' =>    ['rock', 'scissors'],
    'lizard' =>   ['spock', 'paper']
  }






  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def <=>(other_move)
    if VALUES[value] == other_move.value
      1
    elsif value == other_move.value
      0
    else
      -1
    end
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    self.score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.keys.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.keys.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer, :winner

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  # having custom and string objects here as possible values of `winner` is awkward
  def calculate_winner
    self.winner = case human.move <=> computer.move
                  when 1
                    human
                  when -1
                    computer
                  when 0
                    'tie'
                  end
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    calculate_winner
    puts winner == 'tie' ? "It's a tie!" : "#{winner.name} won!"
  end

  def increment_score
    winner.score += 1 unless winner == 'tie'
  end

  def display_score
    increment_score
    puts "The score is #{human.name}: #{human.score}, #{computer.name}: #{computer.score}."
    puts "First to 10 wins!"
  end

  def someone_won?
    human.score == 10 || computer.score == 10
  end

  def display_overall_winner
    puts human.score == 10 ? "#{human.name} is the champion!" : "#{computer.name} is the champion!"
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      display_score
      break if someone_won?
    end
    display_overall_winner
    display_goodbye_message
  end
end

RPSGame.new.play
