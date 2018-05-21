FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@mail.com" }
    sequence(:name) { |n| "Test Name#{n}" }
    password_digest 'password'
    api_key { rand(0..1000) }
    status "active"
  end
end
