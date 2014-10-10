# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_authorization do
    provider "MyString"
    uid "MyString"
    user_id 1
    token "MyString"
    secret "MyString"
  end
end
