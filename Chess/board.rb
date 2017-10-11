require_relative 'piece'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    populate
  end

  def populate
    # @grid.each_with_index do |row, x|
    #   row.each_with_index do |square, y|
    #     if [0, 1].include?(x)
    #       self[[x,y]]= Piece.new(:W, [x,y], self)
    #     elsif [6, 7].include?(x)
    #       self[[x,y]]= Piece.new(:B, [x,y], self)
    #     else
    #       self[[x,y]]= Piece.new(:N, [x,y], self)
    #     end
    #   end
    # end
    @grid.each_with_index do |row, x|
      row.each_with_index do |square, y|
        if [0, 1].include?(x)
          self[[x,y]] = Rook.new(:W, [x, y], self) if (y == 0 || y == 7) && x == 0
          self[[x,y]] = Knight.new(:W, [x, y], self) if (y == 1 || y == 6) && x == 0
          self[[x,y]] = Bishop.new(:W, [x, y], self) if (y == 2 || y == 5) && x == 0
          self[[x,y]] = King.new(:W, [x, y], self) if y == 3 && x == 0
          self[[x,y]] = Queen.new(:W, [x, y], self) if y == 4 && x == 0
          self[[x,y]] = Pawn.new(:W, [x, y], self) if x == 1
        elsif [6, 7].include?(x)
          self[[x,y]] = Rook.new(:B, [x, y], self) if (y == 0 || y == 7) && x == 7
          self[[x,y]] = Knight.new(:B, [x, y], self) if (y == 1 || y == 6) && x == 7
          self[[x,y]] = Bishop.new(:B, [x, y], self) if (y == 2 || y == 5) && x == 7
          self[[x,y]] = King.new(:B, [x, y], self) if y == 3 && x == 7
          self[[x,y]] = Queen.new(:B, [x, y], self) if y == 4 && x == 7
          self[[x,y]] = Pawn.new(:B, [x, y], self) if x == 6
        else
          self[[x,y]] = NullPiece.new(:N, [x, y], self)
        end
      end
    end

  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x,y = pos
    @grid[x][y] = value
  end

  def move_piece(start_pos, end_pos)
    p self[start_pos].current_pos
    p self[end_pos].current_pos
    raise StandardError.new if !self[start_pos].current_moves.include?(end_pos)
    self[start_pos].current_pos = end_pos.dup
    self[end_pos].current_pos = start_pos.dup
    if self[end_pos].color != :N
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
      self[start_pos] = NullPiece.new(:N, start_pos, self)
    else
      self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    end
    # if in_check?(self[end_pos].color)
    #   p "Invalid move. Move into check"
    #   move_piece(start_pos,end_pos)
    # end
  end



  def in_bounds?(n)
    return false if !(0..7).include?(n)
    true
  end


  def in_check?(color)
    king_pos = nil
    @grid.each do |row|
      row.each do |piece|
        if piece.color == color && piece.is_a?(King)
          king_pos = piece.current_pos
        end
      end
    end

    @grid.each do |row|
      row.each do |piece|
        if piece.current_moves.include?(king_pos) && piece.color != color
          return true
        end
      end
    end
    false
  end


  def checkmate?(color)
    if in_check?(color)
      @grid.each do |row|
        row.each do |piece|
          if piece.color == color
            piece.current_moves.each do |move|
              start = piece.current_pos
              ending = move
              move_piece(start, ending)
              if !in_check?(color)
                move_piece(ending, start)
                return false
              else
                move_piece(ending, start)
              end
            end
          end
        end
      end
      return true
    end
    false
  end

end
