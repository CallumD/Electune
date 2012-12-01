FactoryGirl.define do
  factory :album do
    name "MyString"
    release_date "2012-12-01 09:04:35"
    sequence(:spotify_link) {|n| "spotify:link#{n}" }
  end
end
