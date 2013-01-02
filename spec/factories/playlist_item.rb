FactoryGirl.define do
  factory :playlist_item do
    song
    user
    association :playlist
  end
end
