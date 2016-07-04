# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ofcia_payroll_observation_code, :class => 'Ofcia::PayrollObservationCode' do
    name "MyString"
    description "MyText"
  end
end
