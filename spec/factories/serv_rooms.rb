# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :serv_room, :class => 'Serv::Room' do
    name "MyString"
  end
end
