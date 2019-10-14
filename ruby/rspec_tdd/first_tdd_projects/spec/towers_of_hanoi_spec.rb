require "rspec"
require "towers_of_hanoi"

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }

  describe "#initialize" do
    it "initializes with three arrays, each representing the different rods" do
      expect(game.rack.length).to eq(3)
    end

    it "initializes with the first rod having four discs" do
      expect(game.rod1.length).to eq(4)
    end

    it "initializes with the second and third rods empty" do
      expect(game.rod2.empty?).to eq(true)
      expect(game.rod3.empty?).to eq(true)
    end
  end

  describe "#move" do
    context "takes in two rods (rod to take from and rod to add to) as arguments" do
      it "raises an error if not exactly two rods are passed in" do
        expect { game.move(1).to raise_error(ArgumentError) }
        expect { game.move(1, 2, 3).to raise_error(ArgumentError) }
      end

      it "raises an error if non-integers are passed in" do
        expect { game.move([1], [2]) }.to raise_error(ArgumentError)
        expect { game.move("1", "2") }.to raise_error(ArgumentError)
      end
    end

    it "moves one disc at a time" do
      rod_lengths = [game.rod1.length, game.rod2.length, game.rod3.length]
      game.move(1, 3)
      new_rod_lengths = [game.rod1.length, game.rod2.length, game.rod3.length]

      expect(rod_lengths).not_to eq(new_rod_lengths)
    end

    it "raises an error if an empty rod is taken from" do
      expect { game.move(2, 1) }.to raise_error(ArgumentError)
    end

    it "raises an error if a larger disc is moved on top of a smaller disc" do
      game.move(1, 2)
      expect { game.move(1, 2) }.to raise_error(ArgumentError)
    end
  end

  describe "#won?" do
    let(:game) { TowersOfHanoi.new }

    context "when the last rod is full and correctly sorted" do
      it "returns true" do
        game.rod1 = []
        game.rod2 = []
        game.rod3 = [4, 3, 2, 1]
        expect(game.won?).to eq(true)
      end
    end

    context "when the last rod is not full and/or not correctly sorted" do
      it "returns false" do
        game.rod3 = [4, 3]
        expect(game.won?).to eq(false)

        game.rod3 = [3, 4, 1, 2]
        expect(game.won?).to eq (false)
      end
    end
  end
end