require "rspec"
require "hand"

describe Hand do
  let(:deck) { double("deck", :stack => ["card1", "card2", "card3", "card4", "card5", "card6"]) }
  subject(:hand) { Hand.new(deck) }

  describe "#initialize" do
    it "initializes with an empty array" do
      expect(hand.roster).to eq([])
    end

    it "initializes with an unspecified pair calculation" do
      expect(hand.type).to eq(nil)
    end

    it "takes in a deck" do
      expect(hand.deck).to eq(deck)
    end
  end

  describe "#populate_roster" do
    before(:each) { hand.populate_roster }

    it "takes the cards from the deck" do
      expect(deck.stack.length).to eq(1)
    end

    it "populates the roster to have 5 cards" do
      expect(hand.roster.length).to eq(5)
    end
  end

  describe "#calculate_roster" do
    context "when hand is a royal flush" do
      before(:each) do
        hand.roster = [
          Card.new(:heart, "10"),
          Card.new(:heart, "J"),
          Card.new(:heart, "Q"), 
          Card.new(:heart, "K"),
          Card.new(:heart, "A")
        ]
        hand.calculate_roster
      end

      it "sets the type to Royal Flush" do
        expect(hand.type).to eq("Royal Flush")
      end
    end

    context "when hand is a straight flush" do
      before(:each) do
        hand.roster = [
          Card.new(:spade, "5"),
          Card.new(:spade, "6"),
          Card.new(:spade, "7"),
          Card.new(:spade, "8"),
          Card.new(:spade, "9")
        ]
        hand.calculate_roster
      end

      it "sets the type to Straight Flush" do
        expect(hand.type).to eq("Straight Flush")
      end
    end

    context "when hand is a four-of-a-kind" do
      before(:each) do
        hand.roster = [
          Card.new(:heart, "A"),
          Card.new(:club, "A"),
          Card.new(:diamond, "A"),
          Card.new(:spade, "A"),
          Card.new(:heart, "2")
        ]
        hand.calculate_roster
      end

      it "sets the type to Four of a Kind" do
        expect(hand.type).to eq("Four of a Kind")
      end
    end

    context "when hand is a full house" do
      before(:each) do
        hand.roster = [
          Card.new(:spade, "A"),
          Card.new(:diamond, "A"),
          Card.new(:club, "A"),
          Card.new(:heart, "K"),
          Card.new(:spade, "K")
        ]
        hand.calculate_roster
      end

      it "sets the type to Full House" do
        expect(hand.type).to eq("Full House")
      end
    end

    context "when hand is a flush" do
      before(:each) do
        hand.roster = [
          Card.new(:heart, "2"),
          Card.new(:heart, "4"),
          Card.new(:heart, "6"),
          Card.new(:heart, "8"),
          Card.new(:heart, "K")
        ]
        hand.calculate_roster
      end

      it "sets the type to Flush" do
        expect(hand.type).to eq("Flush")
      end
    end

    context "when hand is a Straight" do
      before(:each) do
        hand.roster = [
          Card.new(:heart, "5"),
          Card.new(:club, "6"),
          Card.new(:diamond, "7"),
          Card.new(:spade, "8"),
          Card.new(:heart, "9")
        ]
        hand.calculate_roster
      end

      it "sets the type to Straight" do
        expect(hand.type).to eq("Straight")
      end
    end

    context "when hand is a three-of-a-kind" do
      before(:each) do
        hand.roster = [
          Card.new(:club, "A"), 
          Card.new(:heart, "A"),
          Card.new(:spade, "A"),
          Card.new(:diamond, "2"),
          Card.new(:club, "7"),
        ]
        hand.calculate_roster
      end
    
      it "sets the type to Three of a Kind" do
        expect(hand.type).to eq("Three of a Kind")
      end
    end

    context "when hand is a two pair" do
      before(:each) do
        hand.roster = [
          Card.new(:diamond, "K"),
          Card.new(:club, "K"),
          Card.new(:heart, "Q"),
          Card.new(:spade, "Q"),
          Card.new(:diamond, "J")
        ]
        hand.calculate_roster
      end

      it "sets the type to Two Pair" do
        expect(hand.type).to eq("Two Pair")
      end
    end

    context "when hand is a pair" do
      before(:each) do
        hand.roster = [
          Card.new(:club, "A"),
          Card.new(:heart, "A"),
          Card.new(:spade, "9"),
          Card.new(:diamond, "8"),
          Card.new(:club, "7")
        ]
        hand.calculate_roster
      end

      it "sets the type to Pair" do
        expect(hand.type).to eq("Pair")
      end
    end

    context "when hand is not of a specific winning pattern" do
      before(:each) do
        hand.roster = [
          Card.new(:heart, "A"),
          Card.new(:spade, "8"),
          Card.new(:diamond, "6"),
          Card.new(:club, "4"),
          Card.new(:heart, "2")
        ]
        hand.calculate_roster
      end

      it "sets the type to High Card" do
        expect(hand.type).to eq("High Card")
      end
    end
  end

  describe "#hand_ranking" do
    it "returns a rank based on the type of hand that the hand is" do
      hand.type = "Full House"
      expect(hand.hand_ranking).to eq(3)
    end
  end
end