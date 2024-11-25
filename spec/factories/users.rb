FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "text#{i}@example.com" }
    password { "password" }
  end
end
