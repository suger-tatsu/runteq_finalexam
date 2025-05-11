class CreateGroupAssignmentStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :group_assignment_students do |t|
      t.references :student, foreign_key: true
      t.references :group_assignment, foreign_key: true
      t.references :group, foreign_key: true
      t.timestamps
    end
  end
end
