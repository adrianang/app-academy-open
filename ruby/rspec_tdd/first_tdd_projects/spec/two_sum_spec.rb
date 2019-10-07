require "rspec"
require "two_sum"

describe "Array::two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }
  # is a class method on array
  it "expects to be called on an array" do
    expect { "-1, 0, 2, -2, 1".two_sum }.to raise_error(NoMethodError)
  end

  # all elements in array are integers
  it "expects all elements in the array to be integers" do
    expect { [-1, 0, true, 2, "bear", -2, 1].two_sum }.to raise_error(ArgumentError) 
  end

  # all returned index pairs are ordered by smaller index before bigger index
  it "expects all returned index pairs to be ordered by smaller index before bigger index" do
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end

  # returns an empty array if no two integers in array sum to zero
  it "returns an empty array if no two integers in the array sum to zero" do
    expect([].two_sum).to eq([])
  end
end