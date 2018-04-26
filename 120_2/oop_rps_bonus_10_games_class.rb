require 'pry'
require 'pry-byebug'

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    self.score = Score.new
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

# doesn't really same to make sense as a class since the relationship is has-a vs is-a but learning ex...
class Score < Player
  attr_accessor :value
  def initialize
    self.value = 0
  end
end

class Move
  VALUES = { 'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock' }

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

  def calculate_winner
    self.winner = case human.move <=> computer.move
                  when 1 then human
                  when -1 then computer
                  when 0 then 'tie'
                  end
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    calculate_winner
    puts winner == 'tie' ? "It's a tie!" : "#{winner.name} won!"
  end

  def increment_score
    winner.score.value += 1 unless winner == 'tie'
  end 

  def display_score
    increment_score
    puts "The score is #{human.name}: #{human.score.value}, #{computer.name}: #{computer.score.value}."
    puts "First to 10 wins!"
  end

  def display_overall_winner
    if human.score.value == 10
      puts "#{human.name} wins!"
    else
      puts "#{computer.name} wins!"
    end
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      display_score
      break if human.score.value == 10 || computer.score.value == 10
    end
    display_overall_winner
    display_goodbye_message
  end
end

RPSGame.new.play
