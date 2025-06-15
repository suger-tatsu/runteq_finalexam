require "test_helper"

class Public::GroupAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher = teachers(:one)

    @student = Student.create!(
      name: "テスト生徒",
      gender: "男",               # 必須なら追加
      height: 160.0,
      weight: 55.0,
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

    success = @assignment.save_and_assign_groups
    raise "GroupAssignment保存失敗: #{@assignment.errors.full_messages}" unless success
  end

  test "should get show" do
    get public_group_assignment_path(token: @assignment.public_token)
    assert_response :redirect
    assert_redirected_to public_password_group_assignment_path(token: @assignment.public_token)
  end

  test "should get password" do
    get public_password_group_assignment_path(token: @assignment.public_token)
    assert_response :success
    assert_match "パスワード", response.body
  end

  test "should verify password and redirect to show" do
    post public_verify_password_group_assignment_path(token: @assignment.public_token), params: { password: "sample" }
    assert_response :redirect
    assert_redirected_to public_group_assignment_path(token: @assignment.public_token)
  end
end
