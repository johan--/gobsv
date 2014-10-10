# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cns_timeline do
    name { Faker::Name.name }
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    timeline_date { Faker::Business.credit_card_expiry_date }
  end
end
