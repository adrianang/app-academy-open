require "rspec"
require "stock_picker"

describe "#stock_picker" do
  # takes in an array of stock prices
  it "raises an error if a non-array is passed in" do
    expect { stock_picker("180.32, 178.65, 174.09, 179.62, 177.26") }.to raise_error(TypeError)
  end

  # expects each argument to be a numeric type
  it "raises an error if any argument is not a number" do
    expect { stock_picker([180.32, 178.65, "salmon", 179.62, "birch"]) }.to raise_error(ArgumentError)
  end

  # returns an array pair of most profitable date to buy and sell
  it "returns an array pair of most profitable date to buy and sell" do
    expect(stock_picker([180.32, 178.65, 174.09, 179.62, 177.26])).to eq([2, 3])
  end

  # returns an array of pairs of most profitable dates to buy and sell if there are multiple, equally viable options
  it "returns an array of pairs of most profitable dates to buy and sell if there are multiple, equally viable options" do
    expect(stock_picker([180.32, 178.65, 174.09, 179.62, 179.62])).to eq([[2, 3], [2, 4]])
  end

  # returns an empty array if passed in an empty array
  it "returns an empty array if an empty array is passed in" do
    expect(stock_picker([])).to eq([])
  end
end