# PHASE 2
def convert_to_int(str)
  begin
    number = Integer(str)
  rescue ArgumentError => e
    puts "#{e.message}"
  ensure
    number ||= nil
  end

  number
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError

end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise CoffeeError
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  begin
    puts "Hello, I am a friendly monster. :)"
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError
    puts "Try again!"
    retry
  rescue StandardError
    puts "Not a fruit!"
  end
end

# PHASE 4

class LengthError < StandardError

end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)

    raise ArgumentError.new("name can't be blank") if name.empty?
    raise ArgumentError.new("years known not enough") if yrs_known < 5
    raise ArgumentError.new("fav_pasttime can't be blank") if fav_pastime.empty?
    @yrs_known = yrs_known
    @name = name
    @fav_pastime = fav_pastime

  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
