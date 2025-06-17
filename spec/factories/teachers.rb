FactoryBot.define do
  factory :teacher do
    name { "テスト教師" }
    email { Faker::Internet.unique.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
