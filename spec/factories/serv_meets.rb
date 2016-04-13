# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :serv_meet, :class => 'Serv::Meet' do
    room_id 1
    user_id 1
    audience_type 1
    assistants_number 1
    require_assistance false
    observations "MyText"
    title "MyString"
    start "2016-04-04 14:23:50"
  end
end
