# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll_patron, :class => 'Ofcia::PayrollPatron' do
    employer_id "MyString"
    name "MyString"
    nit "MyString"
    sector_id 1
    economic_activity_id 1
  end
end
