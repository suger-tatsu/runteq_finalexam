require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @teacher = teachers(:one)
  end

  test "ログインページが表示されること" do
    get login_path
    assert_response :success
  end

  test "正しい情報でログインできること" do
    post login_path, params: { email: @teacher.email, password: "password123" }
    assert_redirected_to students_path
    follow_redirect!
    assert_match "ログイン成功", response.body
    assert_equal @teacher.id, session[:teacher_id]
  end

  test "間違った情報ではログインできないこと" do
    post login_path, params: { email: @teacher.email, password: "wrongpass" }
    assert_response :success
    assert_match "メールアドレスまたはパスワードが違います", response.body
    assert_nil session[:teacher_id]
  end

  test "ログアウトできること" do
    # ログインしておく
    post login_path, params: { email: @teacher.email, password: "password123" }
    assert_equal @teacher.id, session[:teacher_id]

    # ログアウト
    delete logout_path
    assert_redirected_to login_path
    follow_redirect!
    assert_match "ログアウトしました", response.body
    assert_nil session[:teacher_id]
  end
end
