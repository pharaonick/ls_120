# after 3 rounds
# if have lost more than 60 % with a choice, remove it from options

# if have won more than 60% with a choice, weight higher

# if opponent has picked something twice in a row, 
# don't pick the thing that beats that

# if opponent has not picked something, weight the winners higher

# MOVEHISTORY MIGHT NEED TO SUBCLASS FROM PLAYER OR BE A MODULE...



# tracker = [['rock', 'paper'], ['spock', 'lizard'], ['scissors', 'paper']]

#   WINNING_MOVES = {
#     'rock' =>     ['scissors', 'lizard'],
#     'paper' =>    ['rock', 'spock'],
#     'scissors' => ['lizard', 'paper'],
#     'spock' =>    ['rock', 'scissors'],
#     'lizard' =>   ['spock', 'paper']
#   }

  ABBREVIATIONS = { 
    'ro' => 'rock',
    'pa' => 'paper',
    'sc' => 'scissors',
    'sp' => 'spock',
    'li' => 'lizard'
  }



results = {:win=>["paper", "scissors", "rock", "paper"], :loss=>["lizard", 'scissors']}

ABBREVIATIONS.values.each_with_object([]) do |move, arr|
  win_count = results[:win].count(move) - results[:loss].count(move)
  win_count.times { arr << move } if win_count > 0
end


Round 1. NICKBOP: rock, qUiCkLeArNeR: rock. Tie!
Round 2. NICKBOP: rock, qUiCkLeArNeR: paper. qUiCkLeArNeR won!
Round 3. NICKBOP: paper, qUiCkLeArNeR: paper. Tie!
Round 4. NICKBOP: scissors, qUiCkLeArNeR: paper. NICKBOP won!
Round 5. NICKBOP: scissors, qUiCkLeArNeR: lizard. NICKBOP won!
Round 6. NICKBOP: spock, qUiCkLeArNeR: spock. Tie!
Round 7. NICKBOP: lizard, qUiCkLeArNeR: paper. NICKBOP won!
Round 8. NICKBOP: lizard, qUiCkLeArNeR: paper. NICKBOP won!
Round 9. NICKBOP: rock, qUiCkLeArNeR: scissors. NICKBOP won!
