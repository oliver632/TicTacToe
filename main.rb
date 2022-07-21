class Player
  def initialize(name)
    @name = name
    @symbol
  end
  attr_accessor :name, :symbol
end

class Board
  def initialize()
    @spots = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  # Displays the board
  def display()
    puts ""
    puts "   #{@spots[0]} | #{@spots[1]} | #{@spots[2]}"
    puts "   ---------"
    puts "   #{@spots[3]} | #{@spots[4]} | #{@spots[5]}"
    puts "   ---------"
    puts "   #{@spots[6]} | #{@spots[7]} | #{@spots[8]}"
    puts ""
  end
  attr_accessor :spots

  def check_winner?(player)
    # All possible win-lines
    lines_with_three = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]]
    # checks every line if it has the player.symbol in all of the spaces
    for lines in lines_with_three do
      check_array = [@spots[lines[0]], @spots[lines[1]], @spots[lines[2]]]
      return true if check_array.all?(player.symbol)
    end
    # returns false if no one has won
    return false
  end

  def tie?()
    tie = true
    for number in 0..8 do
        if (spots[number] == number+1) then tie = false end
    end
    return tie
  end
end

def play_game(board, player_1, player_2)
  turn = 0
  # Runs until a winner is found
  while !board.check_winner?(player_1) && !board.check_winner?(player_2) && !board.tie? do
    # Player 1's turn

    if turn == 0
      board.display()
      puts "#{player_1.name}'s turn, type a number:"
      placement = gets.chomp.to_i
      # Checks if input is correct.
      until board.spots.one?(placement) && placement.is_a?(Integer) && placement < 10 do
        board.display()
        puts "Incorrent input, try again!"
        placement = gets.chomp.to_i
      end
      # Sets the stop to the symbol of the player
      board.spots[placement - 1] = player_1.symbol
      # Switches turn to other player
      turn = 1
      # Does next to check if player_1 won
      next
    end

    if turn == 1
      board.display()
      puts "#{player_2.name}'s turn, type a number:"
      placement = gets.chomp.to_i
      # Checks if input is correct.
      until board.spots.one?(placement) && placement.is_a?(Integer) && placement < 10 do
        board.display()
        puts "Incorrent input, try again!"
        placement = gets.chomp.to_i
      end
      # Sets symbol in the board
      board.spots[placement - 1] = player_2.symbol
      # Sets turn to player_1
      turn = 0
    end
  end
  # Displays winner
  board.display()
  puts ""
  puts "#{player_1.name} won!" if board.check_winner?(player_1)
  puts "#{player_2.name} won!" if board.check_winner?(player_2)
  puts "The game was a TIE." if board.tie?
  puts ""
  sleep(3)

  # checks if player wants to play again
  puts "If you want to play again, type 'yes', otherwise type 'no':"
  play_again = gets.chomp.downcase
  until play_again == "yes" || play_again == "no" do
    puts "Do you want to play again? (yes/no)"
    play_again = gets.chomp.downcase
  end
  if play_again == "yes"
    board = Board.new()
    puts ""
    puts "Starting new game...."
    sleep(2)
    play_game(board, player_1, player_2)
  end
end

board = Board.new()

# Start game intro thingy
puts "Welcome to this game of TicTacToe!"
puts ""
sleep(1)
puts "First, you have to choose the first player's name:"
player_1 = Player.new(gets.chomp)
puts ""
puts "The first player is #{player_1.name}."
sleep(1)
puts ""
puts "Now, choose the second player's name: "
player_2 = Player.new(gets.chomp)
puts ""
puts "The second player is #{player_2.name}."
sleep(1)
puts "Good, #{player_1.name} will be playing against #{player_2.name}."
sleep(1)
puts ""
puts "--------------------------------------------------------------------"
puts ""
puts "Now choose a symbol for each player, to display on the board."
puts "The symbol must be one character long."
puts "If in doubt, just use 'x' and 'y' for each player."
sleep(1)
puts ""
puts "Choose a symbol for #{player_1.name}:"
player_1.symbol = gets.chomp
while player_1.symbol.length != 1 do
  puts "Oops, that symbol is longer than one character, try again:"
  player_1.symbol = gets.chomp
end
puts ""
sleep(1)
puts "Good Job, #{player_1.name}'s symbol is #{player_1.symbol}."
puts ""
sleep(1)
puts "Now, choose a symbol for #{player_2.name}:"
player_2.symbol = gets.chomp
while player_2.symbol.length != 1 do
  puts "Oops, that symbol is longer than one character, try again:"
  player_2.symbol = gets.chomp
end
puts ""
sleep(1)
puts "Well done, #{player_2.name}'s symbol is #{player_2.symbol}."
sleep(2)
puts ""
puts "--------------------------------------------------------------------"
puts ""
puts "Now we are finally ready to play."
puts ""
sleep(1)
puts "Here is the board:"
board.display()
puts ""
sleep(3)
puts "The game works like this:"
puts "The player whose turn it is, puts a piece on the board, "
puts "by typing the corrospoding number on the board."
puts ""
sleep(2)
# End of start procedure

play_game(board, player_1, player_2)

