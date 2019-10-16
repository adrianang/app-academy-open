require "rspec"
require "card"

describe Card do
  subject(:card) { Card.new(:spade, "4") }

  describe "#initialize" do
    it "initializes with a suit" do
      expect(card.suit).to eq(:spade)
    end

    it "initializes with a value" do
      expect(card.value).to eq("4")
    end
  end
end