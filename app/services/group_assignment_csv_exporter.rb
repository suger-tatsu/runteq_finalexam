require "csv"

class GroupAssignmentCsvExporter
  def initialize(group_assignment)
    @group_assignment = group_assignment
  end

  def export
    CSV.generate(headers: true) do |csv|
      csv << ["id", "name", "athletic_ability", "leadership", "cooperation", "science", "humanities"]
      @group_assignment.students.each do |student|
        csv << [
          student.id,
          student.name,
          student.athletic_ability,
          student.leadership,
          student.cooperation,
          student.science,
          student.humanities
        ]
      end
    end
  end
end
