require_relative "hand"

class Player
  attr_accessor :hand, :pot, :game

  def initialize(deck, game)
    @hand = Hand.new(deck)
    @pot = 500
    @game = game
  end

  def discard(*position)    
    args = position.inspect[1..-2].split(",").map { |ele| ele.to_i }
    kept_cards = @hand.roster.reject.with_index { |ele, i| args.include?(i + 1) }
    @hand.roster = kept_cards
  end

  def fold
    return
  end

  def see
    self.pot -= @game.ante
  end

  def raise(new_ante)
    self.pot -= new_ante
  end
end