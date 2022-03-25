# frozen_string_literal: true

# board class, contains:
# @gameBoard
# play method
# checkForVictory method
# player class

# boardClass
class Board
  private

  PLAYER_TOKENS = [1, -1].freeze
  attr_reader :game_board, :players
  attr_accessor :turn, :game_running

  public

  def initialize(player_one = 'Spieler 1', player_two = 'Spieler 2')
    @game_board = self.class.create_game_board
    # @player_one = player_one
    # @player_two = player_two
    @players = [player_one, player_two]
    @game_running = true
    @turn = 0
  end

  def play
    print_board
    puts ''
    game_loop while game_running
  end

  def game_loop
    turn_message
    ask_for_mark
    print_board
    if victory?
      self.game_running = false
      victory_message
    end
    self.turn = turn + 1
    puts ''
  end

  # should become private later, now public for testing
  def print_board
    game_board.each do |line|
      print_line(line)
      puts ''
    end
  end

  def print_line(line)
    line.each do |entry|
      case entry
      when 1
        print '[x]'
      when -1
        print '[o]'
      else
        print '[ ]'
      end
    end
  end

  def victory?
    victory_diagonal_one? || victory_diagonal_two? || victory_horizontals? || victory_verticals?
  end

  def victory_diagonal_one?
    diagonal_sum = 0
    3.times do |i|
      diagonal_sum += game_board[i][i]
    end
    diagonal_sum.abs == 3
  end

  def victory_diagonal_two?
    diagonal_sum = 0
    3.times do |i|
      diagonal_sum += game_board[i][2 - i]
    end
    diagonal_sum.abs == 3
  end

  def victory_horizontals?
    game_board.each do |line|
      horizontal_sum = line.sum
      return true if horizontal_sum.abs == 3
    end
    false
  end

  def victory_verticals?
    game_board_transposed = game_board.transpose
    game_board_transposed.each do |line|
      vertical_sum = line.sum
      return true if vertical_sum.abs == 3
    end
    false
  end

  def victory_message
    victor = players[turn % 2]
    puts "#{victor} wins!"
  end

  def turn_message
    player = players[turn % 2]
    puts "It's #{player}'s turn!"
  end

  def self.create_game_board
    Array.new(3) { |_i| [0, 0, 0] }
  end

  # TODO: Error handling for non numbers and numbers out of range and already checked boxes
  def ask_for_number
    gets.chomp.to_i
  end

  def ask_for_mark
    puts 'Enter line number:'
    line_number = ask_for_number
    puts 'Enter column number:'
    column_number = ask_for_number
    mark_box(line_number, column_number)
  end

  def mark_box(line_number, column_number)
    game_board[line_number][column_number] = PLAYER_TOKENS[turn % 2]
  end
end

new_board = Board.new
# p new_board.gameBoard
new_board.play
