class Player
  # player needs to track move because if we look at human/computer.choose
  # the return value of `choose` is not saved, so it must modify the state of something
  
  attr_accessor :move

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
  end

  # needs to be different based on Player object type
  # not concerned with return value of `choose` method
  # because it's going to modify a value
  def choose
    if human? # need this as a method now
      # prolly choose something
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      # prolly randomize
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end

  def human?
    @player_type == :human
  end
end



# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer) # this could be symbol, string, different word, whatever as long as consistent
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

   def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def play
    display_welcome_message
    human.choose # instance method on player class because human is going to be an object of Player class... need new class!
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play

=begin
to play a game we just need to instantiate a 
new RPSGame object and call `play` on it

`#play` contains the procedural imperative code 
- just a sequence of methods
- begin with low-hanging fruit by defining messages

=end