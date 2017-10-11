require_relative "board"
require "byebug"

module SlidingPiece

  def moves(*dirs)
    result = []
    dirs.each do |dir|
      case dir
      when :diagonal
        result += diagonal_dirs
      when :vertical_horizontal
        result += vertical_horizontal_dirs
      end
    end
    result
  end

  private

  def vertical_horizontal_dirs
    result = []
    sides = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    sides.each do |dir|
      x = @current_pos[0] + dir[0]
      y = @current_pos[1] + dir[1]
      while @board.in_bounds?(x) && @board.in_bounds?(y) && end_pos_valid?([x,y])
        result << [x, y]
        x += dir[0]
        y += dir[1]
      end
      if enemy_at_pos([x, y])
        result << [x, y]
      end
    end
    result
  end

  def diagonal_dirs
    result = []
    diagonal = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    diagonal.each do |dir|
      x = @current_pos[0] + dir[0]
      y = @current_pos[1] + dir[1]
      while @board.in_bounds?(x) && @board.in_bounds?(y) && end_pos_valid?([x,y])
        result << [x, y]
        x += dir[0]
        y += dir[1]
      end

      if enemy_at_pos([x, y])
        result << [x, y]
      end
    end
    result
  end

  private

  # def unblocked_moves_in_dir(dirs)
  #   result = []
  #   # [[1,1],[-1,-1],[1,-1],[-1,1]]
  #   dirs.each do |dir|
  #     direction = [dir[]]
  #     move = [@current_pos[0] + dir[0], @current_pos[1] + dir[1]]]
  #
  #     until blocked?
  #   end
  #   result
  # end

end

module SteppingPiece

  def moves(*dirs)
    result = []
    dirs.each do |dir|
      case dir
      when :single
        result += single_dirs
      when :knight
        result += knight_dirs
      end
    end
    result
  end

  private

  def single_dirs
    result = []
    sides = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [-1, -1], [1, -1], [-1, 1]]
    sides.each do |dir|
      x = @current_pos[0] + dir[0]
      y = @current_pos[1] + dir[1]
      if end_pos_valid?([x,y]) || enemy_at_pos([x,y])
        result << [x, y]
      end
    end
    result
  end

  def knight_dirs
    result = []
    knight_moves = [[2,1], [2,-1], [1,2], [1,-2], [-1,-2], [-1,2], [-2,1], [-2,-1]]
    knight_moves.each do |dir|
      x = @current_pos[0] + dir[0]
      y = @current_pos[1] + dir[1]
      if end_pos_valid?([x,y]) || enemy_at_pos([x,y])
        result << [x, y]
      end
    end
    result
  end

end

class Piece
  attr_accessor :color, :current_pos
  def initialize(color, current_pos, board)
    @color = color
    @current_pos = current_pos
    @board = board
  end

  def end_pos_valid?(end_pos)
    return false unless @board.in_bounds?(end_pos[0]) && @board.in_bounds?(end_pos[1])
    if @board[end_pos].color == :N
      true
    else
      false
    end
  end

  def enemy_at_pos(pos)
    return false unless @board.in_bounds?(pos[0]) && @board.in_bounds?(pos[1])
    @board[pos].color != @color && @board[pos].color != :N
  end

end


class Bishop < Piece
  include SlidingPiece

  def current_moves
    @moves = moves(:diagonal)
  end

end

class Rook < Piece
  include SlidingPiece

  def current_moves
    @moves = moves(:vertical_horizontal)
  end

end

class Queen < Piece
  include SlidingPiece

  def current_moves
    @moves = moves(:vertical_horizontal,:diagonal)
  end

end

class King < Piece
  include SteppingPiece

  def current_moves
    @moves = moves(:single)
  end

end

class Knight < Piece

  include SteppingPiece

  def current_moves
    @moves = moves(:knight)
  end

end

class Pawn < Piece

  def current_moves
    @moves = []
    if @color == :W
      moves = [@current_pos[0] + 1, @current_pos[1]]
      @moves << moves if end_pos_valid?(moves)
      diagonals = [[1,1], [1,-1]]

      diagonals.each do |move|
        check_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
        @moves << check_move if enemy_at_pos(check_move)
      end
    elsif @color == :B
      moves = [@current_pos[0] - 1, @current_pos[1]]
      @moves << moves if end_pos_valid?(moves)
      diagonals = [[-1,1], [-1,-1]]
      diagonals.each do |move|
        check_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
        @moves << check_move if enemy_at_pos(check_move)
      end
    end

    @moves
  end
end

class NullPiece < Piece

  def current_moves
    @moves = []
  end
end
