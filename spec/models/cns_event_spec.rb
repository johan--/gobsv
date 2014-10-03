require 'rails_helper'

RSpec.describe CnsEvent, :type => :model do

  it "has a valid factory" do
    expect(build(:cns_event)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:cns_event, name: nil)).to_not be_valid
  end

  it "is valid without a description" do
    expect(build(:cns_event, description: nil)).to be_valid
  end

  it "is invalid with a duplicate name" do
    cns_event = create(:cns_event)
    expect(build(:cns_event, name: cns_event.name)).to_not be_valid
  end

  it "is invalid with a duplicate case insensitive name" do
    cns_event = create(:cns_event)
    expect(build(:cns_event, name: cns_event.name.swapcase)).to_not be_valid
  end

  it "is invalid without a event_date" do
    expect(build(:cns_event, event_date: nil)).to_not be_valid
  end

  it "is invalid without a valid event_date" do
    expect(build(:cns_event, event_date: "dd/mm/yyyy")).to_not be_valid
  end
end
