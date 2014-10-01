require 'rails_helper'

RSpec.describe CnsProposal, :type => :model do

  it "has a valid factory" do
    expect(build(:cns_proposal)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:cns_proposal, name: nil)).to_not be_valid
  end

  it "is valid without a description" do
    expect(build(:cns_proposal, description: nil)).to be_valid
  end

  it "is invalid with a duplicate name" do
    cns_proposal = create(:cns_proposal)
    expect(build(:cns_proposal, name: cns_proposal.name)).to_not be_valid
  end

  it "is invalid with a duplicate case insensitive name" do
    cns_proposal = create(:cns_proposal)
    expect(build(:cns_proposal, name: cns_proposal.name.swapcase)).to_not be_valid
  end

  it "is invalid without a cns_category_id" do
    expect(build(:cns_proposal, cns_category_id: nil)).to_not be_valid
  end
end
