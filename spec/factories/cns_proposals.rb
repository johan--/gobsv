# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cns_proposal do
    association :cns_category

    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end
end
