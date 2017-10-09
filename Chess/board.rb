require_relative 'piece'

class Board
attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    @grid.each_with_index do |row, index|
      row.map! do |square|
        if [0, 1, 6, 7].include?(index)
          Piece.new
        else
          nil
        end
      end
    end
  end

  def [](pos)
    x,y = pos[0],pos[1]
    @grid[x][y]
  end

  def []=(pos,value)
    x,y = pos[0],pos[1]
    @grid[x][y] = value
  end

  def move_piece(start_pos,end_pos)
    raise "Not valid start position" if !self[start_pos].is_a?(Piece)
    raise "Not valid end position" if self[end_pos].is_a?(Piece)

    self[start_pos],self[end_pos] = self[end_pos],self[start_pos]
  end

end
