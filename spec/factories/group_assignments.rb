FactoryBot.define do
  factory :group_assignment do
    sequence(:title) { |n| "テストグループ分け#{n}" }
    group_count { 2 }
    strategy { "even" }
    ability_selection { [ "athletic_ability" ] }
    ability_weights { { "athletic_ability" => "1" } }
    selected_student_ids { [] }

    association :teacher
  end
end
