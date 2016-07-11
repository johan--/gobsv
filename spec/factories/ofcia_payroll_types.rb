# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll_type, :class => 'Ofcia::PayrollType' do
    name "MyString"
  end
end
