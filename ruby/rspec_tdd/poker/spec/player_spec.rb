require "rspec"
require "player"

describe Player do
  let(:deck) { double("deck") }
  let(:hand) { double("hand", :hand => []) }
  let(:game) { double("game", :pot => 1000, :ante => 10) }
  subject(:player) { Player.new(deck, game) }

  describe "#initialize" do
    before(:each) do
      player.hand = hand
    end

    it "initializes with a hand" do
      expect(player.hand).to eq(hand)
    end

    it "initializes with a pot" do
      expect(player.pot).to eq(500)
    end

    it "takes in a game" do
      expect(player.game).to eq(game)
    end
  end

  describe "#discard" do
    before(:each) do
      player.hand.roster = ["card1", "card2", "card3", "card4", "card5"]
    end

    it "takes in a position within hand of card to discard" do
      player.discard(1)
      expect(player.hand.roster).to eq(["card2", "card3", "card4", "card5"]) 
    end

    it "can discard up to three cards at a time" do
      player.discard(1, 2, 3)
      expect(player.hand.roster).to eq(["card4", "card5"])
    end
  end

  describe "#fold" do
    it "does not affect player's pot" do
      player.fold
      expect(player.pot).to eq(500)
    end
  end

  describe "#see" do
    it "subtracts current ante amount from player's pot" do
      player.see
      expect(player.pot).to eq(490)
    end
  end

  describe "#raise" do
    context "when player raises a valid amount/amount more than current ante" do
      it "takes in new ante amount" do
        expect(player).to receive(:raise).with(20)
        player.raise(20)
      end

      it "subtracts amount more than current ante from player's pot" do
        player.raise(20)
        expect(player.pot).to eq(480)
      end
    end
  end
end