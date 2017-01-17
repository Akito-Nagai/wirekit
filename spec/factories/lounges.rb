FactoryGirl.define do
  factory :lounge do
    sequence(:name) { |n| "lounge-#{n}" }
  end
end
