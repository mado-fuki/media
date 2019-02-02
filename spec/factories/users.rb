FactoryBot.define do
  factory :user do
    name { 'test-user' }
    email { 'test1@example.com' }
    password { 'password' }
  end
end