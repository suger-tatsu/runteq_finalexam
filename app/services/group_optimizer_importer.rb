require "csv"

class GroupOptimizerImporter
  def initialize(csv_path, group_assignment)
    @csv_path = csv_path
    @group_assignment = group_assignment
  end

  def import!
    # CSV → グループ作成 + 生徒割当
    ...
  end

  # 📌 API形式のデータが来る場合はこちらを追加しても良い
  def self.new_from_json(json_data, group_assignment)
    new(nil, group_assignment).tap do |importer|
      importer.import_from_json!(json_data)
    end
  end

  def import_from_json!(json_data)
    @group_assignment.groups.destroy_all

    groups = Array.new(@group_assignment.group_count.to_i) do |i|
      @group_assignment.groups.create!(name: "#{i + 1}班")
    end

    json_data.each do |entry|
      student_id = entry["id"].to_i
      group_index = entry["group_number"].to_i

      group = groups[group_index]
      raise "不正なgroup_number: #{group_index}" unless group

      GroupAssignmentStudent.create!(
        group_assignment: @group_assignment,
        group: group,
        student_id: student_id
      )
    end
  end
end