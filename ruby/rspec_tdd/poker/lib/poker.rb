require_relative "deck"
require_relative "player"

class Poker
  attr_accessor :deck, :players, :current_player, :pot, :ante

  def initialize(num_players)
    @deck = Deck.new
    @players = Array.new(num_players) { Player.new(@deck, self) }
    @current_player = @players.first
    @pot = 1000
    @ante = 10
  end
end