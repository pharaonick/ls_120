# game play could be better, and computer.choose_move logic made more complex
# can no doubt be better organized, but this is better than before...
# biggest problem maybe passing game_data object as arg to computer.choose_move

module Move
  WINNING_MOVES = {
    'rock' =>     ['scissors', 'lizard'],
    'paper' =>    ['rock', 'spock'],
    'scissors' => ['lizard', 'paper'],
    'spock' =>    ['rock', 'scissors'],
    'lizard' =>   ['spock', 'paper']
  }

  def choose_move(_)
    self.move = WINNING_MOVES.keys.sample
  end

  def display_move
    puts "#{name} chose #{move}."
  end

  def determine_round_winner
    if WINNING_MOVES[human.move].include?(computer.move)
      human
    elsif human.move == computer.move
      nil
    else
      computer
    end
  end

  def display_round_winner(winner)
    if winner
      puts "#{winner.name} wins the round!"
    else
      puts "It's a tie!"
    end
  end
end

class Game
  include Move

  attr_accessor :human, :computer, :round_winner, :game_data

  def initialize
    welcome_message
    @human = Human.new
    @computer = the_droid_you_are_looking_for
    @game_data = GameData.new(human, computer)
    @quit = false
  end

  def the_droid_you_are_looking_for
    [Rocky.new, ClassicCutter.new, Exotica.new, LooksBackInAnger.new,
     UnbeatabLol.new, LittleTwist.new].sample
  end

  # method flagged by RC for AbcSize... worth fixing?
  # could break loop out into separate method...
  def play
    display_opponent
    clear_screen(1)

    until game_won? || @quit
      game_data.display_round_details
      human.choose_move
      human.display_move
      computer.choose_move(game_data)
      computer.display_move
      self.round_winner = determine_round_winner
      display_round_winner(round_winner)
      game_data.update(round_winner)
      execute_player_option(display_options)
    end

    display_overall_winner
    goodbye_message
  end

  def welcome_message
    puts "Hi welcome to RPSSL. First to 10. You know what to do!"
  end

  def display_opponent
    puts "Your opponent is #{computer.name}. Good luck!"
  end

  def clear_screen(secs)
    sleep secs
    system('clear') || system('cls')
  end

  def game_won?
    human.score == 10 || computer.score == 10
  end

  def display_options
    puts "Enter 'q' to quit, 'h' for round history, anything else to continue."
    gets.chomp.downcase
  end

  def execute_player_option(option)
    if option == 'q'
      @quit = true
    elsif option == 'h'
      game_data.display_history
    else
      clear_screen(0)
    end
  end

  def display_overall_winner
    puts "You forfeit the game..." if @quit
    if human.score == 10
      puts "#{human.name} is the overall winner!"
    else
      puts "#{computer.name} is the overall winner!"
    end
  end

  def goodbye_message
    puts "Thanks for playing RPSSL. Bye!"
  end
end

class GameData < Game
  attr_accessor :round, :history

  def initialize(human, computer)
    @human = human
    @computer = computer
    @round = 1
    @history = []
  end

  def display_round_details
    output = "Round #{round}. #{human.name}: #{human.score}, "
    output += "#{computer.name}: #{computer.score}."
    puts output
  end

  def update(winner)
    assign_round_winner(winner)
    update_history
    increment_score
    increment_round
  end

  def assign_round_winner(winner)
    self.round_winner = winner
  end

  def update_history
    history << { round: round, human: human.move, computer: computer.move,
                 winner: win_or_tie }
  end

  def win_or_tie
    round_winner ? round_winner.name : "Tie"
  end

  def display_history
    history.each do |hsh|
      output = "Round #{hsh[:round]}. #{human.name} chose #{hsh[:human]}. "
      output += "#{computer.name} chose #{hsh[:computer]}. "
      output += if hsh[:winner] == 'Tie'
                  "The round was tied!"
                else
                  "#{hsh[:winner]} won the round!"
                end
      puts output
    end

    puts "Hit any key to continue."
    gets
    clear_screen(0)
  end

  def increment_score
    round_winner.score += 1 if round_winner
  end

  def increment_round
    self.round += 1
  end

  def getMove(object)
    object.send :move
  end

  def getWinningMoves(name)
    winning_moves_to_add = history.collect do |hsh|
      if hsh[:winner] == name
        return hsh[:computer]
      else
        next
      end
    end
    winning_moves_to_add.compact
  end
end

class Player
  include Move

  attr_accessor :name, :score, :move

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Name can't be empty."
    end
    self.name = name
  end

  def choose_move
    choice = ''
    loop do
      puts "Choose 'rock', 'paper', 'scissors', 'spock', or 'lizard'."
      choice = gets.chomp.downcase
      break if WINNING_MOVES.keys.include?(choice)
      puts "Invalid choice. (You have to type it in full, sorry!)"
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = self.class.name # (could have defined ivars in subclasses)
  end
end

class Rocky < Computer
  def choose_move(_)
    self.move = 'rock'
  end
end

class ClassicCutter < Computer
  def choose_move(_)
    self.move = ['rock', 'paper', 'scissors', 'scissors', 'scissors'].sample
  end
end

class Exotica < Computer
  def choose_move(_)
    self.move = ['spock', 'lizard'].sample
  end
end

class LooksBackInAnger < Computer
  def choose_move(game_data)
    if game_data.round > 1
      self.move = game_data.history[game_data.round - 2][:human]
    else
      super
    end
  end
end

class UnbeatabLol < Computer
  def choose_move(game_data)
    tie = game_data.getMove(:human)
    winners = WINNING_MOVES.select do |_, losing_moves|
      losing_moves.include?(tie)
    end

    self.move = ([tie] + winners.keys).sample
  end
end

class LittleTwist < Computer
  def choose_move(game_data)
    self.move = (WINNING_MOVES.keys + game_data.getWinningMoves(name)).sample
  end
end

Game.new.play
