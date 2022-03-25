# frozen_string_literal: true

# module Victory
module Victory
  private

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
end

# module CheckBox
module CheckBox
  private

  PLAYER_TOKENS = [1, -1].freeze
  def ask_for_number
    number = gets.chomp.to_i - 1
    if number.between?(0, 2)
      number
    else
      puts 'Please enter a number between 1 and 3.'
      ask_for_number
    end
  end

  def ask_for_mark
    puts ''
    puts 'Enter line number:'
    line_number = ask_for_number
    puts ''
    puts 'Enter column number:'
    column_number = ask_for_number
    if (game_board[line_number][column_number]).zero?
      mark_box(line_number, column_number)
    else
      puts 'The box is already checked.'
      ask_for_mark
    end
  end

  def mark_box(line_number, column_number)
    game_board[line_number][column_number] = PLAYER_TOKENS[turn % 2]
  end
end

# boardClass
class Board
  private

  include Victory
  include CheckBox

  attr_reader :game_board, :players
  attr_accessor :turn, :game_running

  public

  def initialize(player_one = 'Spieler 1', player_two = 'Spieler 2')
    @game_board = create_game_board
    @players = [player_one, player_two]
    @game_running = true
    @turn = 0
  end

  def play
    print_board
    puts ''
    game_loop while game_running
  end

  private

  def game_loop
    turn_message
    ask_for_mark
    puts ''
    print_board
    if victory?
      self.game_running = false
      victory_message
    end
    self.turn = turn + 1
    puts ''
    if turn == 9
      print_board
      self.game_running = false
      puts 'Draw!'
    end
  end

  def turn_message
    player = players[turn % 2]
    puts "It's #{player}'s turn!"
  end

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

  def create_game_board
    Array.new(3) { |_i| [0, 0, 0] }
  end
end

puts 'What\'s the name of player one?'
name_one = gets.chomp

puts 'What\'s the name of player two?'
name_two = gets.chomp
puts ''
puts 'Let\'s play Tic-Tac-Toe!'
puts ''

new_board = Board.new(name_one, name_two)
new_board.play
