require "rspec"
require "two_sum"

describe "Array::two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }

  it "expects to be called on an array" do
    expect { "-1, 0, 2, -2, 1".two_sum }.to raise_error(NoMethodError)
  end

  it "expects all elements in the array to be integers" do
    expect { [-1, 0, true, 2, "bear", -2, 1].two_sum }.to raise_error(ArgumentError) 
  end

  it "expects all returned index pairs to be ordered by smaller index before bigger index" do
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end

  it "returns an empty array if no two integers in the array sum to zero" do
    expect([2, 3, 4].two_sum).to eq([])
  end
end