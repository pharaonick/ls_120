# Walk through OOO TTT Spike

# responsibility of the board object is to represent
# the state of the board
class Board
  # INITIAL_MARKER constant initially placed here, but the two times we reference it it is
  # in relation to the square. So makes more sense to put it in Square class.
  # 2 implications: 
  # 1. We can remove that argument from the `Square.new` call in `Board#initialize`
  # provided we set a default value in `Square#initialize`
  # 2. We can remove the namespace resolution from `Square#unmarked?`
  
  # INITIAL_MARKER = ' '
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    @squares[key]
  end

  # re-assign existing marker for square rather
  # than creating whole new Square object
  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  # named like this because it's not returning the square objects
  # but rather their keys
  # method `unmarked` is called on square object at that key

  # note could also be expressed as
  # `@squares.select { |_, sq| sq.unmarked? }.keys`
  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? } 
  end

  def full?
    unmarked_keys.empty?
  end

  # needs to call another method that figures this out and returns 
  # winning marker or nil
  # `!!` will turn a truthy object into the boolean `true` and `nil` into `false`
  def someone_won?
    !!detect_winner
  end

  # the specific winning lines can be represented with an array...

  # def detect_winner
  #   WINNING_LINES.each do |line|
  #     if @squares[line[0]].marker == TTTGame::HUMAN_MARKER && 
  #     @squares[line[1]].marker == TTTGame::HUMAN_MARKER && 
  #     @squares[line[2]].marker == TTTGame::HUMAN_MARKER
  #       return TTTGame::HUMAN_MARKER
  #     elsif @squares[line[0]].marker == TTTGame::COMPUTER_MARKER && 
  #     @squares[line[1]].marker == TTTGame::COMPUTER_MARKER && 
  #     @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
  #       return TTTGame::COMPUTER_MARKER
  #     end
  #   end
  #   nil # if we don't explicitly return this, `each` is the last expression evaluated => caller
  # end

  # this `detect_winner` logic works but it's all a bit messy. Plus:
  #   very nested (prolly not very performant...)
  #   having to call getter on square object to return string to compare with player marker
  #   not DRY?
  # soooo... write in a method you wish you had, then go create it!

  def count_human_marker(squares) # takes an array of square objects as arg
    # creates new array of the square objects' markers, and counts how many are HUMAN_MARKER
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  # def detect_winner
  #   WINNING_LINES.each do |line|
  #     if count_human_marker(@squares.select { |k, _| line.include?(k) }.values) == 3
  #       return TTTGame::HUMAN_MARKER
  #     elsif count_computer_marker(@squares.select { |k, _| line.include?(k) }.values) == 3
  #       return TTTGame::COMPUTER_MARKER
  #     end
  #   end
  #   nil
  # end

  # refactor again using `Hash#values_at`, which takes a key as an argument and returns
  # the value at that key. Can pass in multiple keys `Hash#values_at(first_key, second_key)
  # and it will return their values as an array. 
  # SOOOOO then if we pass in *line as the arg, the splat converts the line array to comma separated args
  # -- it's doing exactly the same as our code above...
  def detect_winner
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.values_at(*line)) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  # (we could also chain a marker getter call onto the get_square_at method
  # called by the board object in display_board. But not ideal...)
  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
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
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board(clear = true)
    system('clear') || system('cls') if clear
    puts "You're a #{human.marker}. Computer is #{computer.marker}."
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  # board represents state of the game so it is the board's
  # responsibility to control square choice
  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    # Whose responsibility to set the square?
    # could be board or human...
    # board.set_square_at(square, mark)
    # or
    # @human.mark(square)

    # NB great idea to stick a binding.pry here
    # to confirm the square and human.marker values
    # are what you think they are before writing the 
    # Board#set_square_at method
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_result
    display_board

    case board.detect_winner
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
      break if %w(y n).include?(answer)
      puts "Sorry, must be 'y' or 'n'."
    end

    # can refactor below two lines to make use of truthiness
    # return false if answer == 'n'
    # return true if answer == 'y'
    answer == 'y'
  end

  def play
    system('clear') || system('cls')
    display_welcome_message

    loop do
      display_board(false) # we don't want to clear the screen the first time through a game

      # KEY POINT
      # whether the board is full seems like it should be the board's responsibility
      # and so it should be an instance method of the Board class.
      # but you could make it `board_full?` and have it a `TTTGame` imethod (but that doesn't really make sense...)
      # Nick comment: we don't care at this point WHO won, so using the board
      # object's state vs multiple calls to player objects to determine if someone 
      # won is probably best...(the latter may not even be reasonably possible...)

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?
        
        display_board
      end
      
      display_result
      break unless play_again?
      board.reset
      system('clear') || system('cls')
      puts "Let's play again!"
      puts ''
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play