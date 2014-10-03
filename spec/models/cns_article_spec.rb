require 'rails_helper'

RSpec.describe CnsArticle, :type => :model do

  it "has a valid factory" do
    expect(build(:cns_article)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:cns_article, name: nil)).to_not be_valid
  end

  it "is valid without a description" do
    expect(build(:cns_article, description: nil)).to be_valid
  end

  it "is invalid with a duplicate name" do
    cns_article = create(:cns_article)
    expect(build(:cns_article, name: cns_article.name)).to_not be_valid
  end

  it "is invalid with a duplicate case insensitive name" do
    cns_article = create(:cns_article)
    expect(build(:cns_article, name: cns_article.name.swapcase)).to_not be_valid
  end

  it "is invalid without a article_date" do
    expect(build(:cns_article, article_date: nil)).to_not be_valid
  end

  it "is invalid without a valid article_date" do
    expect(build(:cns_article, article_date: "dd/mm/yyyy")).to_not be_valid
  end
end
