# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_category, :class => 'Ta::Category' do
    name "MyString"
  end
end
