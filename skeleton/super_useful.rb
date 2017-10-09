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

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  begin
    puts "Hello, I am a friendly monster. :)"
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    raise StandardError if maybe_fruit == "coffee"
  rescue
    retry
  ensure
    reaction(maybe_fruit)
  end
end

# PHASE 4

class LengthError < StandardError

end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @fav_pastime = fav_pastime
    begin
      @yrs_known = yrs_known
      raise StandardError if @yrs_known < 5
      raise LengthError if name.length <= 0 || fav_pastime.length <= 0
    rescue StandardError
      p "Please put in valid years"
      years = gets.chomp.to_i
      @yrs_known = years if years >= 5
    rescue LengthError
      p "Please re-input name"
      name = gets.chomp
      @name = name if name.length > 0
      p "Please re-input favorite pastime"
      pastime = gets.chomp
      @fav_pastime = pastime if pastime.length > 0
    end
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
