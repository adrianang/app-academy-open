# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError => e
    puts "Error: #{e}"
  ensure
    return "nil"
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeRelatedError < StandardError
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeRelatedError.new
  else 
    raise ArgumentError.new
  end 
end

def feed_me_a_fruit
  begin
    puts "Hello, I am a friendly monster. :)"
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeRelatedError => e
    puts "That is not a fruit! But it is coffee! And a monster luvs coffee ;)"
    puts "The ever-so-gracious monster has spared you; try again!"
    retry
  rescue ArgumentError => e
    puts "That is not a fruit! The monster got tired since you didn't feed them a fruit :("
  end
end  

# PHASE 4
class FriendlyError < StandardError
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

    raise FriendlyError.new "We can't be friends... tbh we literally barely know each other." if yrs_known < 5
    raise FriendlyError.new "There's something important you've left out... tbh we can't be friends." if name.empty? || fav_pastime.empty?
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known} years. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


