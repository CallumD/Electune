# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :artist do
    name "MyString"
    sequence(:spotify_link) {|n| "spotify:link#{n}" }
  end
end
