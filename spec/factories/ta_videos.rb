# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_video, :class => 'Ta::Video' do
    priority 1
    article_id nil
    title "MyString"
    description "MyText"
    image ""
    url "MyString"
  end
end
