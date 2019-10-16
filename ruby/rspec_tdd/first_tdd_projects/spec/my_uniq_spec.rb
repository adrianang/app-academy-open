require "rspec"
require "my_uniq"
 
describe '#my_uniq' do
  it "expects to raise an error if an array is not passed" do
    expect { my_uniq(42) }.to raise_error(ArgumentError)
  end

  it "returns an array with no duplicates" do
    expect(my_uniq([2, 7, 1, 1, 5, 2, 7])).to eq([2, 7, 1, 5])
    expect(my_uniq(["button", "cat", "cough syrup", "cat"])).to eq(["button", "cat", "cough syrup"])
  end

  it "returns an empty array if an empty array is passed in" do
    expect(my_uniq([])).to eq([])
  end
end
