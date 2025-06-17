FactoryBot.define do
  factory :student do
    sequence(:name) { |n| "テスト生徒#{n}" }
    gender { "男" }
    height { 160.0 }
    weight { 55.0 }
    athletic_ability { 5 }
    leadership { 5 }
    cooperation { 5 }
    science { 5 }
    humanities { 5 }
    association :teacher
  end
end
