require 'rails_helper'

RSpec.describe GroupAssignmentForm, type: :model do
  let(:teacher) { create(:teacher) }
  let(:student1) { create(:student, teacher: teacher) }
  let(:student2) { create(:student, teacher: teacher) }

  it "有効なパラメータで保存できる" do
    params = {
      title: "フォーム経由の課題",
      group_count: 2,
      strategy: "even",
      student_ids: [student1.id, student2.id],
      ability_selection: ["athletic_ability"],
      ability_weights: { "athletic_ability" => "2" }
    }

    form = GroupAssignmentForm.new(params, teacher: teacher)
    expect(form.save).to be true
  end

  it "無効なデータでは保存されない" do
    form = GroupAssignmentForm.new({}, teacher: teacher)
    expect(form.save).to be false
    expect(form.errors[:title]).to be_present
  end
end
