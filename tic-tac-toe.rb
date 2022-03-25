# board class, contains:
  #@gameBoard
  #play method
  #checkForVictory method
# player class

class Player
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Board

  attr_reader :gameBoard

  def initialize()
    @gameBoard = self.class.createGameBoard()
  end

  #should become private later, now public for testing
  def printBoard()
    self.gameBoard.each do |line|
      line.each do |entry|
        if entry == 1
          print '[x]'
        elsif entry == -1
          print '[o]'
        else
          print '[ ]'
        end
      end
      puts ' '
    end
  end


  private 
  def self.createGameBoard()
    gameBoard = Array.new(3) {|i| [1, 0, -1]}
    return gameBoard
  end
end

new_board = Board.new()
#p new_board.gameBoard 
new_board.printBoard()
