require "colorize"
require_relative "cursor"
require_relative "board"

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], @board)
  end

end
