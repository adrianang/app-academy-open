require_relative "hand"

class Player
  attr_accessor :hand, :pot, :game, :folded

  def initialize(deck, game)
    @hand = Hand.new(deck)
    @pot = 500
    @game = game
    @folded = false
  end

  def discard(positions)
    kept_cards = @hand.roster.reject.with_index { |ele, i| positions.include?(i) }
    @hand.roster = kept_cards
    puts "@hand.roster:"
    p @hand.roster
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