FactoryGirl.define do
  factory :client do
    sequence(:email) { |n| "person-#{n}@example.org" }
    sequence(:name) { |n| "person-#{n}" }
    password "password"
  end
end
