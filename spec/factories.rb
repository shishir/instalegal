FactoryGirl.define do
  factory :client do
    sequence(:email) { |n| "client-#{n}@example.org" }
    sequence(:name) { |n| "client-#{n}" }
    password "password"
  end

  factory :lawyer do
    sequence(:email) { |n| "lawyer-#{n}@example.org" }
    sequence(:name) { |n| "lawyer-#{n}" }
    description "desc"
    password "password"
  end

end
