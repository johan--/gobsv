# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inv_product_movement, :class => 'Inv::ProductMovement' do
    kind 1
    cause 1
    comments "MyText"
    product_id 1
    warehouse_id 1
    quantity 1
    user_id 1
  end
end
