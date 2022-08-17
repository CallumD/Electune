FactoryBot.define do
  factory :song do
    sequence(:name) { |n| "song name#{n}" }
    length { 60 }
    sequence(:link) { |n| "spotify:link#{n}" }
    album
    after(:create) { |song| FactoryBot.create(:performer, song_id: song.id) }
  end
end
