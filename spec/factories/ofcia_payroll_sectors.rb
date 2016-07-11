# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll_sector, :class => 'Ofcia::PayrollSector' do
    name "MyString"
  end
end
