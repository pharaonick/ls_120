# We can:
# - display welcome
# - have human choose (choice saved as ivar)
# - have computer choose (ditto)
# - display goodbye
# So just need to implement `display_winner`

class Player
  attr_accessor :move

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

   def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  # no need to pass any values
  # because imethod has access to the ivars in the class (@human, @computer)
  # these ivars also have access to the move the human or computer made
  # can access that move by calling the getter method for the move on the player object
  def display_winner
    puts "You chose #{human.move}." ######## THIS BIT HERE.... WHAT IS HUMAN -- we instantiate a Player obj and assign to @human, and another to @computer
    puts "The computer chose #{computer.move}."

    case human.move
    when 'rock'
      puts "It's a tie!" if computer.move == 'rock'
      puts "You won!" if computer.move == 'scissors'
      puts "Computer won!" if computer.move == 'paper'
    when 'paper'
      puts "It's a tie!" if computer.move == 'paper'
      puts "You won!" if computer.move == 'rock'
      puts "Computer won!" if computer.move == 'scissors'
    when 'scissors'
      puts "It's a tie!" if computer.move == 'scissors'
      puts "You won!" if computer.move == 'paper'
      puts "Computer won!" if computer.move == 'rock'
    end
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play