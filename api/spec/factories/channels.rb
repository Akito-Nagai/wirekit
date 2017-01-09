FactoryGirl.define do
  factory :channel do
    sequence(:name) { |n| "channel-#{n}" }
    lounge
  end
end
