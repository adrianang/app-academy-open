# require "colorize" # Uncomment this line for the sequence text to appear in color!

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      self.take_turn
    end

    self.game_over_message
    self.reset_game
  end

  def take_turn
    self.show_sequence
    sleep(1)
    system("clear")

    puts "A game of SIMON!"
    puts "Your turn!"
    self.require_sequence
    
    if !@game_over
      self.round_success_message
      sleep(1)
      @sequence_length += 1
    end
  end

  def show_sequence
    begin
      system("clear")
      puts "A game of SIMON!"
      self.add_random_color
      @seq.each { |color| puts color.colorize(color.to_sym) }
    rescue NoMethodError => exception
      puts @seq
    end
  end

  def require_sequence
    user_input = gets.chomp
    
    if user_input != @seq.join(" ")
      @game_over = true
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "You got the sequence! Get ready for the next round!"
  end

  def game_over_message
    puts "Oh no! You guessed the wrong sequence! Game over :("
    puts "Total score: #{ @sequence_length - 1 }"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
