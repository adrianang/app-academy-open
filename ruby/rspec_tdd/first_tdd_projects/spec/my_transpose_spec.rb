require "rspec"
require "my_transpose"

describe "#my_transpose" do
  it "takes in an array as an argument" do
    expect { my_transpose("0, 1, 2, 3, 4, 5, 6, 7, 8") }.to raise_error(ArgumentError) 
  end

  it "raises an error if array to transpose is not square in dimension" do
    expect { my_transpose([[0, 1, 2, 3], [4, 5, 6, 7]]) }.to raise_error("Not a square matrix")
  end
  
  it "raises an error if the matrix elements are not all integers" do
    expect { my_transpose([[0, 1, "2"], [3, true, 5], ["dog", 7, 8]]) }.to raise_error("The matrix is not comprised of integers") 
  end

  it "returns a two_dimensional array with transposed elements" do
    expect(my_transpose([[0, 1, 2], [3, 4, 5], [6, 7, 8]])).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end
end