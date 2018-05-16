=begin
Describe game
  Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
  marking a square. The first player to mark 3 squares in a row wins.

Extract nouns & verbs
  Nouns: board, player, square, grid
  Verbs: play, mark

Organize nouns & verbs
  Board
  Square
  Player
    - mark
    - play

Spike
  Sketch out possible classes and start thining about their objects' states
=end

class Board
  def initialize
    # we need some way to model the 3x3 grid. Maybe "squares"?
    # what data structure should we use?
    # - array/hash of Square objects?
    # - array/hash of strings or integers?

    # Nick e.g.
    @grid = Array.new(9) { |el| el = Square.new }
    # what does it actually look like during game?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
    # Nick e.g.
    @status = nil # updates to 'X' or 'O', at which point becomes unavailable
  end
end

class Player
  def initialize
    # maybe a "marker" to keep track of this player's symbol (ie, 'X' or 'O')
  end

  def mark

  end

  def play

  end
end

# unclear whether we need all these or how to organize them
# definitely need orchestration engine though:

class TTTGame
  def play

  end
end

# we'll kick off the game like this, which implies we don't need Player#play
game = TTTGame.new
game.play


# flesh out TTTGame#play by invoking methods we wish existed

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

# All the above is enough scaffolding to start exploring deeper...