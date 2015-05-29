# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_article, :class => 'Ta::Article' do
    title "MyString"
    summary "MyText"
    content "MyText"
  end
end
