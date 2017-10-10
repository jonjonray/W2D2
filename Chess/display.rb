require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  attr_accessor :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], @board)
  end

  def render
    @board.grid.each_with_index do |line, x|
      string = ""
      line.each_with_index do |i, y|
        if [x, y] == @cursor.cursor_pos
          string += i.value.to_s.colorize(:background => :red)
        else
          string += i.value.to_s
        end
      end
      puts string
    end
  end
end
