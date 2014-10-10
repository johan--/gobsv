require 'rails_helper'

RSpec.describe CnsTimeline, :type => :model do

  it "has a valid factory" do
    expect(build(:cns_timeline)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:cns_timeline, name: nil)).to_not be_valid
  end

  it "is invalid without a description" do
    expect(build(:cns_timeline, description: nil)).to_not be_valid
  end

  it "is invalid with a duplicate name" do
    cns_timeline = create(:cns_timeline)
    expect(build(:cns_timeline, name: cns_timeline.name)).to_not be_valid
  end

  it "is invalid with a duplicate case insensitive name" do
    cns_timeline = create(:cns_timeline)
    expect(build(:cns_timeline, name: cns_timeline.name.swapcase)).to_not be_valid
  end
end
