# game play could be better, and computer.choose_move logic made more complex
# can no doubt be better organized, but this is better than before...
# is the `Game#initialize` too complex now?
# are we still passing around more than needed?
# wondering if we even need the `GameData` subclass...?
# all that info might be easier kept in `Game`. Not sure. Anyway...

module Move
  WINNING_MOVES = {
    'rock' =>     ['scissors', 'lizard'],
    'paper' =>    ['rock', 'spock'],
    'scissors' => ['lizard', 'paper'],
    'spock' =>    ['rock', 'scissors'],
    'lizard' =>   ['spock', 'paper']
  }

  def choose_move
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
    @computer.assign_collaborators(@game_data, @human)
    @quit = false
  end

  def the_droid_you_are_looking_for
    [Rocky.new, ClassicCutter.new, Exotica.new, LooksBackInAnger.new,
     UnbeatabLol.new, LittleTwist.new].sample
  end

  def play
    display_opponent
    clear_screen(1)
    game_loop until game_won? || @quit
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

  # rubocop:disable Metrics/AbcSize
  # it's 18.03/18 which I'm fine with...
  def game_loop
    game_data.display_round_details
    human.choose_move
    human.display_move
    computer.choose_move
    computer.display_move
    self.round_winner = determine_round_winner
    display_round_winner(round_winner)
    game_data.update(round_winner)
    execute_player_option(display_options)
  end
  # rubocop:enable Metrics/AbcSize

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
end

class Player
  include Move

  attr_accessor :name, :score, :move

  def initialize
    set_name
    @score = 0
    @move = nil
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
  attr_accessor :game_data, :human
  def set_name
    self.name = self.class.name
  end

  def assign_collaborators(game_data, human)
    @game_data = game_data
    @human = human
  end

  def round
    game_data.round
  end

  def move_history
    game_data.history
  end

  def human_move
    human.move
  end
end

class Rocky < Computer
  def choose_move
    self.move = 'rock'
  end
end

class ClassicCutter < Computer
  def choose_move
    self.move = ['rock', 'paper', 'scissors', 'scissors', 'scissors'].sample
  end
end

class Exotica < Computer
  def choose_move
    self.move = ['spock', 'lizard'].sample
  end
end

class LooksBackInAnger < Computer
  def choose_move
    if round > 1
      self.move = move_history[round - 2][:human]
    else
      super
    end
  end
end

class UnbeatabLol < Computer
  def choose_move
    tie = human_move
    winners = WINNING_MOVES.select do |_, losing_moves|
      losing_moves.include?(human_move)
    end

    self.move = ([tie] + winners.keys).sample
  end
end

class LittleTwist < Computer
  def choose_move
    winning_moves_to_add = move_history.each_with_object([]) do |data_hsh, arr|
      arr << data_hsh[:computer] if data_hsh[:winner] == name
    end

    self.move = (WINNING_MOVES.keys + winning_moves_to_add).sample
  end
end

Game.new.play
