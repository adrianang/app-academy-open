require_relative "card"

class Deck
  attr_accessor :stack

  def initialize
    @stack = []
    self.make_deck
    self.stack.shuffle!
  end

  def make_deck
    suits = [:heart, :spade, :club, :diamond]
    values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

    suits.each do |suit|
      values.each do |value|
        @stack << Card.new(suit, value)
      end
    end
  end
end