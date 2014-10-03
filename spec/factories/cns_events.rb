# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cns_event do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    event_date { Faker::Business.credit_card_expiry_date }
  end
end
