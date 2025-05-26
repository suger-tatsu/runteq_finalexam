require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = teachers(:one) # fixtures/teachers.yml の one を使う
    post login_url, params: { email: @teacher.email, password: "password123" }
  end

  test "should get index" do
    get students_url
    assert_response :success
  end
end
