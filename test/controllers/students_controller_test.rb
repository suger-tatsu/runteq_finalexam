require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = teachers(:one)
    post login_url, params: {
      session: {
        email: @teacher.email,
        password: "password123"
      }
    }
  end

  test "should get index" do
    get students_url
    assert_response :success
  end
end
