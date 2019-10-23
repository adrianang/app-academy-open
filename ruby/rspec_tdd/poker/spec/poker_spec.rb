require "rspec"
require "poker"

describe Poker do
  subject(:poker) { Poker.new(4) }

  describe "#initialize" do
    it "holds a deck of cards" do
      expect(poker.deck).to be_a(Deck)
    end

    it "takes in a number of players" do
      expect(poker.players.length).to eq(4)
    end

    it "keeps track of whose turn it is" do
      expect(poker.current_player).to be_a(Player)
    end

    it "keeps track of the amount in the pot" do
      expect(poker.pot).to eq(1000)
    end
  end
end