# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_page, :class => 'Ta::Page' do
    name "MyString"
    content "MyText"
    slug "MyString"
  end
end
