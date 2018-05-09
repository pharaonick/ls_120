# Code review https://launchschool.com/posts/d4694021
=begin

- rememeber Rubocop is only a guideline... but it does suggest areas to improve
- for AbcSize complexity, assignment counts too which is why changing
  setters to ivars won't help
- s/getter vs ivar = important if need to do processing on data
  other than that it's personal preference (consistency is good)
    QUESTION: would you create an attr_* just to have that consistency even if
    the ivar does not need to be available outside the class?

- heredoc for multiline output e.g. 89-91 -- QUESTION it's not multiline,
  but me trying to solve for the line length complaint. Suggestions?

- `calcuate_winner` logic should be owned by `Move` not `RPSSLGame`

- I'm not sure Human#choose needs access to the entire move history.
  Since it only uses the round number, I would probably just pass that in.

- Rather than the Player objects knowing how the Move::ABBREVIATIONS data
  is structured, you could have a .valid? method which you could use
  on line 94 such as Move.valid?(choice).
  You could then accept choice as the argument for Move#initialize,
  which would remove the extra knowledge from Human#choose.

- I don't see any reason for the if/else on lines 128 and 130.
  You can just include line 129 as another case clause.
  DUUUUUUH missed that during refactoring to make a bit simpler...!

- #looks_back_in_anger_move doesn't need the whole history either.

- Instead of returning 'Tie'. I would return nil,
  which would allow you do to if winner on line 219.

- Your RPSSLGame object is responsible for adding to the move history.
  That is logic that should be handled by MoveHistory.
  I would make a method for adding a new result to the history,
  which can just be passed the data it needs to record a result.

- Your game loop is really well written and concise. Great job!
  The biggest issue I see in your code is that
  your players know a lot about how moves are structured. [QUESTION --- understand what saying but why problem???]
  That is easy to resolve for humans, but not quite as simple for
  the computer player.


  NOTES ON RESTRUCTURING
  - `Move` class would perhaps have been better off as an object whose state includes 
  both player moves and who won
  - 
=end
# rubocop:enable Style

class Move
  ABBREVIATIONS = {
    'ro' => 'rock',
    'pa' => 'paper',
    'sc' => 'scissors',
    'sp' => 'spock',
    'li' => 'lizard'
  }

  WINNING_MOVES = {
    'rock' =>     ['scissors', 'lizard'],
    'paper' =>    ['rock', 'spock'],
    'scissors' => ['lizard', 'paper'],
    'spock' =>    ['rock', 'scissors'],
    'lizard' =>   ['spock', 'paper']
  }

  attr_accessor :value

  def self.valid?(move_choice)
    ABBREVIATIONS.key?(move_choice)
  end

  def self.calculate_winner(human, computer)
    case human.move <=> computer.move
    when 1
      human
    when -1
      computer
    when 0
      nil
    end
  end

  def initialize(choice)
    self.value = ABBREVIATIONS.key?(choice) ? ABBREVIATIONS[choice] : choice
  end

  def <=>(other_move)
    if WINNING_MOVES[value].include?(other_move.value)
      1
    elsif value == other_move.value
      0
    else
      -1
    end
  end

  def to_s
    value
  end
end

class MoveHistory
  attr_accessor :tracker, :round, :results

  def initialize
    self.tracker = []
    @formatted_tracker = []
    self.results = { win: [], loss: [] }
    self.round = 1
  end

  def update_tracker(human_move, computer_move)
    tracker << [human_move, computer_move]
  end

  def format_tracker(human, computer, winner)
    output1 = "Round #{round}. "
    output2 = "#{human.name}: #{tracker.last[0]}, "
    output3 = "#{computer.name}: #{tracker.last[1]}. "
    output4 = winner ? "#{winner.name} won!" : "Tie!"
    @formatted_tracker << output1 + output2 + output3 + output4
  end

  def display_moves
    @formatted_tracker.each { |move| puts move }
    puts "Hit 'return' to continue."
    gets
  end

  def update_results(winner, computer_move)
    case winner
    when Computer
      results[:win] << computer_move
    when Human
      results[:loss] << computer_move
    end
  end

  def increment_round
    self.round += 1
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
    player_name = ''
    loop do
      puts "What's your name?"
      player_name = gets.chomp
      break unless player_name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = player_name
  end

  def choose(round)
    system('clear') || system('cls')
    choice = nil
    loop do
      output1 = "Round #{round}. "
      output2 = "Please choose 'ro' (rock), 'pa' (paper), 'sc' (scissors), "
      output3 = "'sp' (spock), or 'li' (lizard):"
      puts output1 + output2 + output3
      choice = gets.chomp.downcase
      break if Move.valid?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  # rubocop:disable Metrics/MethodLength
  def set_name
    choice = ''
    loop do
      output1 = "Do you want to play the standard droid (enter '1') "
      output2 = "or one with personality ('2')?"
      puts output1 + output2
      choice = gets.chomp
      break if ['1', '2'].include?(choice)
      puts "Sorry, invalid choice."
    end

    if choice == '1'
      self.name = 'littleTWIST'
    else
      self.name = ['Rocky', 'Classic_Cutter', 'EX0T!CA',
                   'LooksBackInAnger', 'UnbeatabLOL'].sample
    end

    puts "Your opponent is #{name}. First to 10 wins."
    puts "Hit 'enter' to continue."
    gets
  end

  # rubocop:disable Metrics/LineLength
  def choose(move_history, human_move)
    self.move = case name
                when 'littleTWIST'
                  Move.new(weighted_move(move_history.results))
                when 'Rocky'
                  Move.new('rock')
                when 'Classic_Cutter'
                  Move.new(['rock', 'paper', 'scissors', 'scissors', 'scissors'].sample)
                when 'EX0T!CA'
                  Move.new(['lizard', 'spock'].sample)
                when 'LooksBackInAnger'
                  looks_back_in_anger_move(move_history.round, move_history.tracker)
                when 'UnbeatabLOL'
                  Move.new([human_move.value, my_move_wins(human_move.value)].sample)
                end
  end
  # rubocop:enable Metrics/MethodLength

  # needs access to move history round and tracker
  def looks_back_in_anger_move(round, tracker)
    if round > 1
      Move.new(tracker[round - 2].first)
    else
      Move.new(Move::ABBREVIATIONS.values.sample)
    end
  end

  def my_move_wins(human_move)
    winning_choices = Move::WINNING_MOVES.select do |_, possible_computer|
      possible_computer.include?(human_move)
    end
    winning_choices.keys.sample
  end

  # needs access to move history results only
  def weighted_move(history)
    winning_move_surplus = Move::ABBREVIATIONS.values.each_with_object([]) do |move, arr|
      win_count = history[:win].count(move) - history[:loss].count(move)
      win_count.times { arr << move } if win_count > 0
    end
    (winning_move_surplus + Move::ABBREVIATIONS.values).sample
  end
  # rubocop:enable Metrics/LineLength
end

class RPSSLGame
  attr_accessor :human, :computer, :winner

  def initialize
    self.human = Human.new
    system('clear') || system('cls')
    display_welcome_message
    self.computer = Computer.new
    @move_history = MoveHistory.new
  end

  def display_welcome_message
    explanation = <<~EXP
    Hi #{human.name}, welcome to Rock, Paper, Scissors, Spock, Lizard!

    It's like Rock-Paper-Scissors, except (deep breath)...
    Scissors cuts paper covers rock crushes lizard
    poisons spock smashes scissors decapitates lizard
    eats paper disproves spock vaporizes rock crushes scissors!

    Got it? Hit 'enter' to continue.
    EXP

    puts explanation
    gets
  end

  # kinda weird to have `calculate_winner` as a Class method but I guess is a function of
  # my Move objects pertaining to a single move only
  def display_winner
    output1 = "#{human.name} chose #{human.move}. "
    output2 = "#{computer.name} chose #{computer.move}."
    puts output1 + output2
    self.winner = Move.calculate_winner(human, computer)
    puts winner ? "#{@winner.name} won!" : "It's a tie!"
  end

  def increment_score
    winner.score += 1 if winner
  end

  def display_score
    increment_score
    output1 = "The score is #{human.name}: #{human.score}, "
    output2 = "#{computer.name}: #{computer.score}."
    puts output1 + output2
  end

  def update_all_trackers(human, computer, winner)
    @move_history.update_tracker(human.move.value, computer.move.value)
    @move_history.format_tracker(human, computer, winner)
    @move_history.update_results(winner, computer.move.value)
  end

  # rubocop:disable Metrics/LineLength
  def offer_move_history
    puts "Enter 'h' for a history of moves, 'q' to quit, anything else to continue."
    choice = gets.chomp.downcase
    if choice == 'h'
      @move_history.display_moves
    elsif choice == 'q'
      @quit = true
    end
  end
  # rubocop:enable Metrics/LineLength

  def quit?
    @quit
  end

  def someone_won?
    human.score == 10 || computer.score == 10
  end

  def display_overall_winner
    if quit?
      puts "You forfeit the match. #{computer.name} is the champion!"
    elsif human.score == 10
      puts "#{human.name} is the champion!"
    else
      puts "#{computer.name} is the champion!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Goodbye!"
  end

  def play
    loop do
      human.choose(@move_history.round)
      computer.choose(@move_history, human.move)
      display_winner
      display_score
      update_all_trackers(human, computer, winner)
      offer_move_history
      @move_history.increment_round
      break if someone_won? || quit?
    end

    display_overall_winner
    display_goodbye_message
  end
end

RPSSLGame.new.play
