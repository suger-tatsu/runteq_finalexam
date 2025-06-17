require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:teacher) { create(:teacher, password: "password", password_confirmation: "password") }

  describe "ログイン機能" do
    it "正しい情報でログインできる" do
      post login_path, params: { session: { email: teacher.email, password: "password" } }
      expect(response).to redirect_to(students_path)
      follow_redirect!
      expect(response.body).to include("ログインしました")
    end

    it "誤ったパスワードでログインできない" do
      post login_path, params: { session: { email: teacher.email, password: "wrong" } }
      expect(response.body).to include("メールアドレスまたはパスワードが無効です")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "ログアウト機能" do
    it "ログアウトできる" do
      post login_path, params: { session: { email: teacher.email, password: "password" } }
      delete logout_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("ログアウトしました")
    end
  end
end
