# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inv_warehouse, :class => 'Inv::Warehouse' do
    name "MyString"
  end
end
