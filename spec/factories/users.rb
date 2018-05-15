FactoryBot.define do
  factory :user do
    email 'test@mail.com'
    name 'Test Name'
    password_digest 'password'
  end
end
