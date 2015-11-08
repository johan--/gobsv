# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inv_unit, :class => 'Inv::Unit' do
    name "MyString"
  end
end
