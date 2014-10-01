require 'rails_helper'

RSpec.describe CnsCategory, :type => :model do

  it "has a valid factory" do
    expect(build(:cns_category)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:cns_category, name: nil)).to_not be_valid
  end

  it "is valid without a description" do
    expect(build(:cns_category, description: nil)).to be_valid
  end

  it "is invalid with a duplicate name" do
    cns_category = create(:cns_category)
    expect(build(:cns_category, name: cns_category.name)).to_not be_valid
  end

  it "is invalid with a duplicate case insensitive name" do
    cns_category = create(:cns_category)
    expect(build(:cns_category, name: cns_category.name.swapcase)).to_not be_valid
  end
end
