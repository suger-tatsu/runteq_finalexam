require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = teachers(:one)  # test/fixtures/teachers.yml に定義されたもの
  end

  test "ログインページが表示されること" do
    get login_path
    assert_response :success
  end

  test "正しい情報でログインできること" do
    post login_path, params: {
      session: {
        email: @teacher.email,
        password: "password123",
        remember_me: "1"
      }
    }
    assert_redirected_to students_path
    follow_redirect!
    assert_match "ログインしました", response.body
    assert_equal @teacher.id, session[:teacher_id]
  end

  test "間違った情報ではログインできないこと" do
    post login_path, params: {
      session: {
        email: @teacher.email,
        password: "wrongpass"
      }
    }
    assert_includes [ 200, 422 ], response.status
    assert_match "メールアドレスまたはパスワードが無効です", response.body
    assert_nil session[:teacher_id]
  end

  test "ログアウトできること" do
    post login_path, params: {
      session: {
        email: @teacher.email,
        password: "password123"
      }
    }
    assert_equal @teacher.id, session[:teacher_id]

    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_match "ログアウトしました", response.body
    assert_nil session[:teacher_id]
  end
end
