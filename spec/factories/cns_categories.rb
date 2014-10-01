# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :cns_category do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end
end
