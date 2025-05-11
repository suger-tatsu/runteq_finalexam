class CreateGroupStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :group_students do |t|
       t.references :student, foreign_key: true  # 生徒ID
       t.references :group, foreign_key: true  # グループID
      t.timestamps
    end
  end
end
