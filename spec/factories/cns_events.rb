# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cns_event do
    name "MyString"
    description "MyText"
    event_date "2014-10-02"
  end
end
