# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :req_product_requirement, :class => 'Req::ProductRequirement' do
    requirement_id 1
    product_id 1
    quantity 1
  end
end
