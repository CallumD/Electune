# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :performer do
    song
    artist
  end
end
