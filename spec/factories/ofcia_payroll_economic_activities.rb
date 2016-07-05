# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll_economic_activity, :class => 'Ofcia::PayrollEconomicActivity' do
    name "MyString"
    economic_activity_group 1
  end
end
