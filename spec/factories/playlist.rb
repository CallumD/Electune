FactoryGirl.define do
  factory :playlist do
    sequence(:name) { |n| "name#{n}" }
    start_time Time.current
  end
end
