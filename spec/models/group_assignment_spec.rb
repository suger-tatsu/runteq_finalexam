require 'rails_helper'

RSpec.describe GroupAssignment, type: :model do
  let(:teacher) { create(:teacher) }
  let(:student1) { create(:student, teacher: teacher) }
  let(:student2) { create(:student, teacher: teacher) }

  describe ".new_from_params" do
    it "パラメータからGroupAssignmentを正しく生成できる" do
      params = {
        title: "サンプル課題",
        group_count: 1,
        strategy: "even",
        student_ids: [ student1.id, student2.id ],
        ability_selection: [ "athletic_ability" ],
        ability_weights: { "athletic_ability" => "2" }
      }

      assignment = GroupAssignment.new_from_params(params, teacher)
      expect(assignment).to be_valid
      expect(assignment.selected_student_ids).to match_array([ student1.id, student2.id ])
    end
  end
end
