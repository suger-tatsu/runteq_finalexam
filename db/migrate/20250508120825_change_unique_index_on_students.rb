class ChangeUniqueIndexOnStudents < ActiveRecord::Migration[8.0]
  def change
    remove_index :students, name: "index_students_on_name"

    add_index :students, [ :name, :teacher_id ], unique: true, name: "index_students_on_name_and_teacher_id"
  end
end
