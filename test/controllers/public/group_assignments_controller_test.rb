require "test_helper"

class Public::GroupAssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assignment = GroupAssignment.new(
      title: "テスト用",
      teacher: teachers(:one),
      public_token: "testtoken",
      public_enabled: true
    )
    @assignment.public_password = "sample"
    @assignment.save!
  end

  test "should get show" do
    get public_group_assignment_path(token: @assignment.public_token)
    assert_response :redirect  # ← ここを変更
    assert_redirected_to public_password_group_assignment_path(token: @assignment.public_token)
  end

  test "should get password" do
    get public_password_group_assignment_path(token: @assignment.public_token)
    assert_response :success
  end

  test "should verify password" do
    post public_verify_password_group_assignment_path(token: @assignment.public_token), params: { password: "sample" }
    assert_response :redirect  # ← ここを変更
    assert_redirected_to public_group_assignment_path(token: @assignment.public_token)
  end
end
