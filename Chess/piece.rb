require_relative "board"

module SlidingPiece


  def moves

  end

  private

  def move_dirs

  end

  def horizontal_dirs

  end

  def diagonal_dirs
    result = []
    diagonal = [[1,1],[-1,-1],[1,-1],[-1,1]]
    diagonal.each do |dir|

      end
    end




  def unblocked_moves_in_dir(x,y)

  end

end

module SteppingPiece

  def moves

  end

  private

  def move_diffs

  end

end

class Piece
  attr_accessor :value

  def initialize(value,current_pos,board)
    @value = value
    @current_pos = current_pos
    @board = board
  end



end


class King < Piece
end


class Knight < Piece
end


class Pawn < Piece
end


class NullPiece < Piece
end

class Bishop < Piece
end

class Rook < Piece
end

class Queen < Piece
end
