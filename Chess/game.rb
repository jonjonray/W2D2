require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new("Donald", :B, @display)
    @player2 = Player.new("Peter", :W, @display)
    @current_player = @player1
  end

  def play
    until over?
      begin
        moves = @current_player.play_turn
        @board.move_piece(moves[0],moves[1])
      rescue StandardError
        retry
        puts "Not valid move"
      end
      switch_player
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def over?
    @board.checkmate?(:B) || @board.checkmate?(:W)
  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new

  game.play
end
