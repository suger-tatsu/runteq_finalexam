require 'rails_helper'

RSpec.describe "Public::GroupAssignments", type: :request do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:student, teacher: teacher) }

  let(:assignment) do
    GroupAssignment.new_from_params({
      title: "公開用課題",
      group_count: 1,
      strategy: "even",
      student_ids: [student.id],
      ability_selection: ["athletic_ability"],
      ability_weights: { "athletic_ability" => "1" }
    }, teacher).tap do |a|
      a.public_token = "testtoken"
      a.public_enabled = true
      a.public_password = "secret"
      raise a.errors.full_messages.join(", ") unless a.save_and_assign_groups
    end
  end

  describe "GET /public/group_assignments/:token" do
    it "パスワードページにリダイレクトされる" do
      get public_group_assignment_path(token: assignment.public_token)
      expect(response).to redirect_to(public_password_group_assignment_path(token: assignment.public_token))
    end
  end

  describe "GET /public/group_assignments/:token/password" do
    it "パスワード入力画面が表示される" do
      get public_password_group_assignment_path(token: assignment.public_token)
      expect(response.body).to include("パスワード")
    end
  end

  describe "POST /public/group_assignments/:token/verify_password" do
    it "正しいパスワードで表示ページへ遷移できる" do
      post public_verify_password_group_assignment_path(token: assignment.public_token),
           params: { password: "secret" }

      expect(response).to redirect_to(public_group_assignment_path(token: assignment.public_token))
    end
  end
end
