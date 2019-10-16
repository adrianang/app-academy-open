require "rspec"
require "stock_picker"

describe "#stock_picker" do
  it "raises an error if a non-array is passed in" do
    expect { stock_picker("180.32, 178.65, 174.09, 179.62, 177.26") }.to raise_error(TypeError)
  end

  it "raises an error if any argument is not a number" do
    expect { stock_picker([180.32, 178.65, "salmon", 179.62, "birch"]) }.to raise_error(ArgumentError)
  end

  it "returns an array pair of most profitable date to buy and sell" do
    expect(stock_picker([180.32, 178.65, 174.09, 179.62, 177.26])).to eq([2, 3])
  end

  it "returns an array of pairs of most profitable dates to buy and sell if there are multiple, equally viable options" do
    expect(stock_picker([180.32, 178.65, 174.09, 179.62, 179.62])).to eq([[2, 3], [2, 4]])
  end

  it "returns an empty array if an empty array is passed in" do
    expect(stock_picker([])).to eq([])
  end
end