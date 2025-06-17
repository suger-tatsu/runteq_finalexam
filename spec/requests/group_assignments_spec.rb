require 'rails_helper'

RSpec.describe "GroupAssignments", type: :request do
  let(:teacher) { create(:teacher, password: "password") }
  let(:student1) { create(:student, teacher: teacher) }
  let(:student2) { create(:student, teacher: teacher) }

  before do
    # ログイン処理（セッションにteacher_idをセット）
    post login_path, params: { session: { email: teacher.email, password: "password" } }
  end

  describe "POST /group_assignments" do
    it "有効なデータでグループ作成できる" do
      expect {
        post group_assignments_path, params: {
          group_assignment: {
            title: "テストグループ",
            group_count: 1,
            strategy: "even",
            student_ids: [student1.id, student2.id],
            ability_selection: ["athletic_ability"],
            ability_weights: { athletic_ability: "1" }
          }
        }
      }.to change { GroupAssignment.count }.by(1)

      expect(response).to redirect_to(group_assignments_path)
      follow_redirect!
      expect(response.body).to include("グループ分けを作成しました")
    end

    it "バリデーションエラーで作成できない場合は再描画される" do
      post group_assignments_path, params: {
        group_assignment: {
          title: "",
          group_count: 0,
          strategy: nil,
          student_ids: [],
          ability_selection: [],
          ability_weights: {}
        }
      }

      expect(response.body).to include("エラーがあります")
      expect(response).to have_http_status(:ok) # render :new の場合
    end
  end
end
