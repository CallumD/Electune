FactoryGirl.define do
  factory :album do
    sequence(:name) { |n| "MyString#{n}" }
    release_date '2012-12-01 09:04:35'
    sequence(:link) { |n| "spotify:link#{n}" }
  end
end
