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

  def initialize(value)
    self.value = value
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

  def format(human, computer, winner)
    output1 = "Round #{round}. "
    output2 = "#{human.name}: #{tracker.last[0]}, "
    output3 = "#{computer.name}: #{tracker.last[1]}. "
    output4 = winner == 'Tie' ? "Tie!" : "#{winner.name} won!"
    @formatted_tracker << output1 + output2 + output3 + output4
  end

  def display_moves
    @formatted_tracker.each { |move| puts move }
    puts "Hit 'return' to continue."
    gets
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

  def choose(move_history)
    system('clear') || system('cls')
    choice = nil
    loop do
      output1 = "Round #{move_history.round}. "
      output2 = "Please choose 'ro' (rock), 'pa' (paper), 'sc' (scissors), "
      output3 = "'sp' (spock), or 'li' (lizard):"
      puts output1 + output2 + output3
      choice = gets.chomp.downcase
      break if Move::ABBREVIATIONS.keys.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(Move::ABBREVIATIONS[choice])
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
    if name == 'LooksBackInAnger'
      self.move = looks_back_in_anger_move(move_history)
    else
      self.move = case name
                  when 'littleTWIST'
                    Move.new(weighted_move(move_history))
                  when 'Rocky'
                    Move.new('rock')
                  when 'Classic_Cutter'
                    Move.new(['rock', 'paper', 'scissors', 'scissors', 'scissors'].sample)
                  when 'EX0T!CA'
                    Move.new(['lizard', 'spock'].sample)
                  when 'UnbeatabLOL'
                    Move.new([human_move.value, my_move_wins(human_move.value)].sample)
                  end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def looks_back_in_anger_move(history)
    if history.round > 1
      Move.new(history.tracker[history.round - 2].first)
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

  def weighted_move(history)
    winning_move_surplus = Move::ABBREVIATIONS.values.each_with_object([]) do |move, arr|
      win_count = history.results[:win].count(move) - history.results[:loss].count(move)
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

  def calculate_winner
    self.winner = case human.move <=> computer.move
                  when 1
                    human
                  when -1
                    computer
                  when 0
                    'Tie'
                  end
  end

  def display_winner
    output1 = "#{human.name} chose #{human.move}. "
    output2 = "#{computer.name} chose #{computer.move}."
    puts output1 + output2
    calculate_winner
    puts winner == 'Tie' ? "It's a tie!" : "#{@winner.name} won!"
  end

  def increment_score
    winner.score += 1 unless winner == 'Tie'
  end

  def display_score
    increment_score
    output1 = "The score is #{human.name}: #{human.score}, "
    output2 = "#{computer.name}: #{computer.score}."
    puts output1 + output2
  end

  def update_move_history
    @move_history.tracker << [human.move.value, computer.move.value]
    @move_history.format(human, computer, winner)
    @move_history.round += 1
  end

  def update_results
    case winner
    when Computer
      @move_history.results[:win] << winner.move.value
    when Human
      @move_history.results[:loss] << computer.move.value
    end
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
      human.choose(@move_history)
      computer.choose(@move_history, human.move)
      display_winner
      display_score
      update_move_history
      update_results
      offer_move_history
      break if someone_won? || quit?
    end

    display_overall_winner
    display_goodbye_message
  end
end

RPSSLGame.new.play
