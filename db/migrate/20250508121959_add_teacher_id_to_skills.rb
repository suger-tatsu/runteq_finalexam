class AddTeacherIdToSkills < ActiveRecord::Migration[8.0]
  def change
    add_column :skills, :teacher_id, :integer 
    add_index :skills, [:name, :teacher_id], unique: true, name: "index_skills_on_name_and_teacher_id" 
  end
end
