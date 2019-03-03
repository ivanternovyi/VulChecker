FactoryBot.define do
  factory :user do |u|
    u.email { 'test@mail.com' }
    u.password { 'password' }
  end
end
