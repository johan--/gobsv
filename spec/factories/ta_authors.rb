# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_author, :class => 'Ta::Author' do
    name "MyString"
    twitter "MyString"
    user nil
  end
end
