require_relative "cursor"
require_relative "display"
class Player

  def initialize(name, color, display)
    @name = name
    @color = color
    @display = display
  end

  def play_turn
    @display.render
    puts "Pick the piece you want to move"
    first_pos = @display.cursor.get_input
    system("clear")
    until !first_pos.nil?
      @display.render
      first_pos = @display.cursor.get_input
      system("clear")
    end
    first_pos = first_pos.dup
    puts "Pick where you want to move it"
    @display.render
    second_pos = @display.cursor.get_input
    system("clear")
    until !second_pos.nil?
      @display.render
      second_pos = @display.cursor.get_input
      system("clear")
    end
    [first_pos, second_pos]
  end
end
