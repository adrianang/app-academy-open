require "rspec"
require "deck"

describe Deck do
  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "initializes with an empty array" do
      expect(deck.stack).to eq([])
    end
  end
  
  describe "#make_deck" do
    it "populates the empty stack with standard 52 card set" do
      deck.make_deck
      expect(deck.stack.length).to eq(52)
    end
  end
end