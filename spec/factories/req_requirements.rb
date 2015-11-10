# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :req_requirement, :class => 'Req::Requirement' do
    code "MyString"
    admin_id 1
  end
end
