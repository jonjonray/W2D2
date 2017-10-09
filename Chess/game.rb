require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    play_turn
  end

  def play
    until over?
      play_turn
    end
  end

  def play_turn
    @display.render
    puts "Enter a move"
    @display.cursor.get_input
    system("clear")
  end

  def over?

  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
