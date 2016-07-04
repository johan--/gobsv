# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll_status, :class => 'Ofcia::PayrollStatus' do
    name "MyString"
    description "MyText"
  end
end
