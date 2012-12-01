# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    name "MyString"
    length "MyString"
    spotify_link "MyString"
    album_id 1
  end
end
