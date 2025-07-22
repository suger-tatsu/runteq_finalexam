require 'rails_helper'

RSpec.describe GroupAssignmentQuery do
  let(:teacher) { create(:teacher) }

  before do
    create(:group_assignment, title: "英語の課題", teacher: teacher)
    create(:group_assignment, title: "数学の課題", teacher: teacher)
  end

  it "タイトルで検索できる" do
    results = GroupAssignmentQuery.new(teacher.group_assignments, { q: "英語" }).call
    expect(results.count).to eq(1)
    expect(results.first.title).to eq("英語の課題")
  end

  it "並び替え（作成順）ができる" do
    results = GroupAssignmentQuery.new(teacher.group_assignments, { sort: "created_at_desc" }).call
    expect(results.first.title).to eq("数学の課題")
  end
end
