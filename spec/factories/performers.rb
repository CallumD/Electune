# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :performer do
    song
    artist
  end
end
