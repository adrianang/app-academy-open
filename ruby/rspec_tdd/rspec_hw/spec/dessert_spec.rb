require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  let(:invalid_dessert) { Dessert.new("cake", "hecka", "Guy Fieri") }
  subject(:dessert) { Dessert.new("cake", 20, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(20)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { invalid_dessert }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("flour")
      expect(dessert.ingredients.length).to eq(1)
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient("flour")
      dessert.add_ingredient("sugar")
      dessert.add_ingredient("chocolate chips")
      dessert.add_ingredient("egg")
      dessert.add_ingredient("matcha")
      before_mixing = dessert.ingredients.dup
      dessert.mix!
      expect(dessert.ingredients).to_not eq(before_mixing)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      before_eating = dessert.quantity
      dessert.eat(2)
      expect(dessert.quantity).to eq(before_eating - 2)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(200) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Emeril the Great Baker")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
