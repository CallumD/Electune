FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com" }
    password 'C0MpL3Xp4sS!'
    password_confirmation 'C0MpL3Xp4sS!'
  end
end
