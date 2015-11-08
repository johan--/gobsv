# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inv_product, :class => 'Inv::Product' do
    code "MyString"
    name "MyString"
  end
end
