FactoryBot.define do
  factory :user do
    name { 'test-user' }
    email { 'test1@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end