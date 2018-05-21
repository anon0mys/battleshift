FactoryBot.define do
  factory :artie, class: :user do
    name 'Artie'
    email 'comp@ai.com'
    password_digest 'password'
    api_key { rand(0..1000) }
    status 'active'
  end
end
