FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "text#{i}@example.com" }
    password { "password" }

    trait :admin do
      admin { true }
    end
  end
end
