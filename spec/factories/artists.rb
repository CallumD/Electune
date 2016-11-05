# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:spotify_link) { |n| "spotify:link#{n}" }
  end
end
