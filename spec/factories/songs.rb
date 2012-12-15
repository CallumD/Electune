FactoryGirl.define do
  factory :song do
    name "song name"
    length 60
    sequence(:spotify_link) {|n| "spotify:link#{n}" }
    album
  end
end
