class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def vulnerable_square(player_marker)
    unmarked_index = nil

    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      markers = squares.map(&:marker)

      if markers.count(player_marker) == 2 &&
         markers.count(Square::INITIAL_MARKER) == 1
        unmarked_index = markers.index(Square::INITIAL_MARKER)
        return line[unmarked_index]
      end
    end

    nil
  end

  def square_five_free?
    unmarked_keys.include?(5)
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def marked_by?(player_marker)
    marker == player_marker
  end
end

class Player
  attr_accessor :score, :marker, :name

  def initialize(name = nil)
    @name = name
    @score = 0
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new(%w[t!ct@c tAkt1k t0eTAc].sample)
    @first_to_move = nil
    @round = 1
  end

  # rubocop:disable Metrics/MethodLength
  # it's only two over and clear to follow
  def play
    game_introductions

    loop do
      set_markers_and_first_mover

      loop do
        clear_screen_and_display_board
        loop_of_player_moves
        display_result
        break if someone_won_match?
        display_play_again_message
        reset
      end

      clear
      display_champion
      break unless rematch?
      reset_game_data
    end

    display_goodbye_message
  end
  # rubocop:enable Metrics/MethodLength

  private

  def clear
    system("clear") || system("cls")
  end

  def join_or(nums)
    if nums.size == 1
      nums.first.to_s
    else
      nums[0..-2].join(', ') + ", or #{nums.last}"
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe! First to five wins..."
    puts ""
  end

  def display_markers
    output =  "#{human.name} is '#{human.marker}'. "
    output += "#{computer.name} is '#{computer.marker}'."
    puts output
    puts ""
  end

  def display_first_to_move
    output = @first_to_move == human.marker ? human.name : computer.name
    puts "Ok. #{output} goes first..."
    sleep 2
  end

  def display_play_again_message
    puts "Round #{@round + 1} coming up..."
    puts ""
    sleep 2
  end

  def display_champion
    puts "Final score: #{human.score} - #{computer.score}"
    output = human.score == 5 ? human.name : computer.name
    puts "#{output} is the champion!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe. Goodbye."
  end

  # rubocop:disable Metrics/AbcSize
  # only deals with outputting something, and simple to understand
  def display_board
    puts "#{human.name}: #{human.marker}, #{computer.name}: #{computer.marker}"
    puts "Round #{@round}."
    puts "Score: #{human.score} - #{computer.score}"
    puts ""
    board.draw
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
      increment_score(true)
    when computer.marker
      puts "#{computer.name} won!"
      increment_score
    else
      puts "It's a tie!"
    end
    sleep 1
  end

  def increment_score(is_human = false)
    is_human ? human.score += 1 : computer.score += 1
  end

  def valid_name?(name)
    !!(name =~ /\A.*\S+.*\z/)
  end

  def human_enters_name
    name = ''

    loop do
      puts "What do you want to be called? (Can't be blank/only spaces.)"
      name = gets.chomp
      break if valid_name?(name)
      puts "Invalid entry. Please try again."
    end

    human.name = name
  end

  def welcome_human
    puts "Great. Hi #{human.name}! Your opponent is #{computer.name}..."
    puts ""
  end

  def option_to_choose_human_marker
    puts "Enter 'c' to choose your own marker, any other key for the default."
    choice = gets.chomp.downcase
    choice == 'c' ? choose_human_marker : human.marker = 'X'
  end

  def valid_marker?(char)
    !!(char =~ /\A\S{1}\z/)
  end

  def choose_human_marker
    choice = ''
    loop do
      puts "Enter a single character to use as your marker."
      puts "This is case-sensitive, and you can't choose 'space' or 'return'."
      choice = gets.chomp
      break if valid_marker?(choice)
      puts "Invalid choice. Try again."
    end

    human.marker = choice
  end

  def set_computer_marker
    computer.marker = human.marker == 'O' ? 'X' : 'O'
  end

  def choose_first_to_move
    choice = nil
    puts "Who's going first?"

    loop do
      puts "1 (#{human.name}), 2 (#{computer.name}), 3 (random)"
      choice = gets.chomp
      break if %w[1 2 3].include?(choice)
      puts "Sorry, invalid choice. Try again."
    end

    self.first_to_move = choice
  end

  def first_to_move=(choice)
    @first_to_move = case choice
                     when '1' then human.marker
                     when '2' then computer.marker
                     else
                       [human.marker, computer.marker].sample
                     end
  end

  def set_current_marker
    @current_marker = @first_to_move
  end

  def game_introductions
    clear
    display_welcome_message
    human_enters_name
    welcome_human
  end

  def set_markers_and_first_mover
    option_to_choose_human_marker
    set_computer_marker
    display_markers
    choose_first_to_move
    display_first_to_move
    set_current_marker
  end

  def loop_of_player_moves
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def human_moves
    puts "Choose a square (#{join_or(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_move_options
    if board.vulnerable_square(computer.marker)
      computer_attack
    elsif board.vulnerable_square(human.marker)
      computer_defend
    elsif board.square_five_free?
      computer_neutral_move(5)
    else
      computer_neutral_move
    end
  end

  def computer_neutral_move(square = board.unmarked_keys.sample)
    board[square] = computer.marker
  end

  def computer_attack
    board[board.vulnerable_square(computer.marker)] = computer.marker
  end

  def computer_defend
    board[board.vulnerable_square(human.marker)] = computer.marker
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_move_options
      @current_marker = human.marker
    end
  end

  def someone_won_match?
    human.score == 5 || computer.score == 5
  end

  def reset
    board.reset
    @current_marker = @first_to_move
    @round += 1
  end

  def rematch?
    answer = nil

    loop do
      puts "Would you like a rematch? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def reset_game_data
    board.reset
    human.score = 0
    computer.score = 0
    @round = 1
  end
end

game = TTTGame.new
game.play
