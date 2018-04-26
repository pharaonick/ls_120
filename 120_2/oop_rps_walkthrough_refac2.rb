class Move # collaborator object
  VALUES = %w[rock paper scissors]

  def initialize(value)
    @value = value # could have a guard clause to make sure value is one of VALUES
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    if rock?
      return true if other_move.scissors? # so now we need to define `scissors?`
      return false
    elsif paper?
      return true if other_move.rock?
      return false
    elsif scissors?
      return true if other_move.paper?
      return false
    end
  end

  def <(other_move)
    if rock?
      return true if other_move.paper?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    elsif scissors?
      return true if other_move.rock?
      return false
    end
  end

  # needed so we can display winner (though you could also use a getter)
  def to_s
    @value
  end
end


class Player
  attr_accessor :move, :name

  def initialize
    set_name
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
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  # can't just set `move` to string because needs to point to actual `Move` object
  def choose
    # mv = Move::VALUES.sample
    # self.move = Move.new(mv)
    # or easier
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

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

  # this is basically the whole of the logic of who wins the game, right here
  # because the moves are strings, so no better way to compare
  # i.e. can't do human.move > computer.move
  # unleeeesssss
  # the move instance variable itself is an object of a custom class, vs a string
  # if it is a custom object, we can tell it how to compare against itself
  # begin by commenting out the nested ifs in case statement, and 
  # writing the code you wish existed!
  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."

    if human.move > computer.move # this is actually an instance method call on the `Move` obj: `if human.move.>(computer.move)`, and this method `>` needs to be defined for the `Move` class
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end

    # case human.move
    # when 'rock'
    #   puts "It's a tie!" if computer.move == 'rock'
    #   puts "#{human.name} won!" if computer.move == 'scissors'
    #   puts "#{computer.name} won!" if computer.move == 'paper'
    # when 'paper'
    #   puts "It's a tie!" if computer.move == 'paper'
    #   puts "#{human.name} won!" if computer.move == 'rock'
    #   puts "#{computer.name} won!" if computer.move == 'scissors'
    # when 'scissors'
    #   puts "It's a tie!" if computer.move == 'scissors'
    #   puts "#{human.name} won!" if computer.move == 'paper'
    #   puts "#{computer.name} won!" if computer.move == 'rock'
    # end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return true if answer == 'y'
    return false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play