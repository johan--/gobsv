# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_comment, :class => 'Ta::Comment' do
    article nil
    comment nil
    name "MyString"
    email "MyString"
    comment "MyText"
    status 1
  end
end
