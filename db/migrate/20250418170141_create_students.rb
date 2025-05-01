class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.integer :student_id
      t.string :name
      t.string :gender
      t.float :height
      t.float :weight
      t.integer :athletic_ability
      t.integer :science
      t.integer :humanities
      t.integer :leadership
      t.integer :cooperation

      t.timestamps
    end
    add_index :students, :name, unique: true
  end
end
