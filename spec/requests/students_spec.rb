require 'rails_helper'

RSpec.describe "Students", type: :request do
  let(:teacher) { create(:teacher, password: "password") }
  let!(:student1) { create(:student, teacher: teacher, name: "田中") }
  let!(:student2) { create(:student, teacher: teacher, name: "佐藤") }

  before do
    post login_path, params: { session: { email: teacher.email, password: "password" } }
  end

  describe "GET /students" do
    it "全体の一覧が表示される" do
      get students_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("田中", "佐藤")
    end

    it "検索機能が動作する（名前で検索）" do
      get students_path, params: { q: "田中" }
      expect(response.body).to include("田中")
      expect(response.body).not_to include("佐藤")
    end

    it "並び替え（名前の昇順）が動作する" do
      get students_path, params: { sort: "name_asc" }
      expect(response.body.index("佐藤")).to be < response.body.index("田中")
    end
  end
end
