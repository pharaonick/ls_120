require 'pry'
require 'pry-byebug'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line) # => array of square objects
      return squares.first.marker if winning_line?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  # this is never calle from outside the class
  # (`Board#winning_marker` is called by `TTTGame#display_result` so cannot be private)
  def winning_line?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max # markers are strings so compare alphabetically...
  end

  ## less idiomatic alternative to above (does not require `Square#marked?`)
  # def winning_line?(squares)
  #   return false if squares.any? { |square| square.unmarked? }
  #   squares[0].marker == squares[1].marker && squares[1].marker == squares[2].marker
  # end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_player = 'human'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear
    system('clear') || system('cls')
  end

  # rubocop:disable Metrics/LineLength
  def display_board
    puts "You're a #{human.marker}. Computer is #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end
  # rubocop:enable Metrics/LineLength

  def clear_screen_and_display_board
    clear
    display_board
  end 

  # could potentially set this up as a Player imethod? Though would need access to @board...

  def current_player_moves
    @current_player == 'human' ? human_moves : computer_moves
  end


  # Note how `TTTGame` acts as an orchestrating class that mediates the 
  # collaboration between `Player` and `Board` objects so they don't need
  # to know anything about each other directly...
  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
    toggle_player('computer') # can just set directly...
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
    toggle_player('human')
  end

  def toggle_player(player)
    @current_player = player
  end

  def human_turn?
    @current_player == 'human'
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = ''

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include?(answer)
      puts "Sorry, must be 'y' or 'n'."
    end

    answer == 'y'
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      # loop do
      #   human_moves
      #   break if board.someone_won? || board.full?

      #   computer_moves
      #   break if board.someone_won? || board.full?

      #   clear_screen_and_display_board
      # end

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      # Nick note...this calls `board.winning_marker` again -- maybe better to assign
      # an ivar after initial `board.someone_won?` call?
      display_result
      break unless play_again?

      reset
      display_play_again_message
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
