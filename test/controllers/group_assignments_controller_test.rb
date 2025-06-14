require "test_helper"

class GroupAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)
    @student = Student.create!(
      name: "テスト生徒",
      athletic_ability: 5,
    leadership: 4,
    cooperation: 3,
    science: 2,
    humanities: 1,
    teacher: @teacher
  )

  @assignment = GroupAssignment.new(
    title: "テスト用課題",
    teacher: @teacher,
    public_token: "testtoken",
    public_enabled: true,
    group_count: 1,
    ability_selection: [ "athletic_ability" ],
    strategy: "even"
  )

  @assignment.selected_student_ids = [ @student.id ]
  @assignment.ability_weights = { "athletic_ability" => 1 }
  @assignment.public_password = "sample"
  @assignment.save_and_assign_groups
end
end
