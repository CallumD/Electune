FactoryGirl.define do
  factory :song do
    name "song name"
    length 60
    sequence(:spotify_link) {|n| "spotify:link#{n}" }
    album
    after(:create) { |song| FactoryGirl.create(:performer, song_id: song.id) }
  end
end
