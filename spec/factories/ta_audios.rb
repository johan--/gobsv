# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_audio, :class => 'Ta::Audio' do
    priority 1
    article nil
    title "MyString"
    description "MyText"
    url "MyString"
    image ""
  end
end
