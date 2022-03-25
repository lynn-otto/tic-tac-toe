# frozen_string_literal: true

# board class, contains:
# @gameBoard
# play method
# checkForVictory method
# player class

# playerClass
class Player
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

# boardClass
class Board
  attr_reader :game_board

  def initialize(player_one = Player.new('Spieler 1', 'x'), player_two = Player.new('Spieler 2', 'o'))
    @game_board = self.class.create_game_board
    @player_one = player_one
    @player_two = player_two
    @game_running = true
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

  def self.create_game_board
    Array.new(3) { |_i| [0, 0, 0] }
  end
end

new_board = Board.new
# p new_board.gameBoard
new_board.print_board
puts new_board.victory_diagonal_one?
puts new_board.victory_verticals?
new_board.print_board
