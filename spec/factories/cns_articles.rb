# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cns_articles, :class => 'CnsArticle' do
    name "MyString"
    description "MyText"
    new_date "2014-10-02"
  end
end
