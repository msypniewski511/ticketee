FactoryBot.define do
  factory :ticket do
    name { "Example ticket" }
    description { "An example ticket, nothing more" }
    project { nil }
    association :author, factory: :user
  end
end
