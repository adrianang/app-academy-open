class TowersOfHanoi
  attr_accessor :rack, :rod1, :rod2, :rod3

  def initialize
    @rack = Array.new(3) {[]}
    self.initialize_rack
    @rod1 = @rack[0]
    @rod2 = @rack[1]
    @rod3 = @rack[2]
  end
  
  def initialize_rack
    @rack[0] = [4, 3, 2, 1]
  end

  def move(original_rod, new_rod)
    raise ArgumentError.new("Not a valid rack (integer)") if !original_rod.is_a?(Integer) || !new_rod.is_a?(Integer)
    raise ArgumentError.new("Rod is empty") if @rack[original_rod - 1].empty?
    if !@rack[new_rod - 1].empty?
      raise ArgumentError.new("Cannot move a larger disc on top of a larger disc") if @rack[original_rod - 1].last > @rack[new_rod - 1].last
    end

    @rack[new_rod - 1].push(@rack[original_rod - 1].pop)
  end

  def won?
    return true if @rod3 == [4, 3, 2, 1] && @rod1.empty? & @rod2.empty?
    false    
  end

  def play
    until self.won?
      begin
        self.render
        remove_from = self.remove_from
        add_to = self.add_to(remove_from)
      rescue ArgumentError => e
        puts "That rod cannot be picked; try again."
        puts ""
        retry
      end

      self.move(remove_from, add_to)
      puts ""
    end

    puts "You won! Final towers:"
    self.render
  end

  def render
    puts "The Towers of Hanoi (but sideways)"
    puts "1: #{ @rod1 }"
    puts "2: #{ @rod2 }"
    puts "3: #{ @rod3 }"
  end

  def remove_from
    puts "Which disc would you like to move?"
    remove_from = gets.chomp.to_i
    raise ArgumentError.new if @rack[remove_from - 1].empty?
    remove_from
  end

  def add_to(original_rod)
    puts "Which rod would you like to move it to?"
    add_to = gets.chomp.to_i
    if !@rack[add_to - 1].empty?
      raise ArgumentError.new if (@rack[add_to - 1].last < @rack[original_rod - 1].last)
    end
    add_to
  end
end