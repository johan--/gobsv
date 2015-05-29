# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ta_image, :class => 'Ta::Image' do
    imageable nil
  end
end
