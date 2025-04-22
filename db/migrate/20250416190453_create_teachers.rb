class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
    add_index :teachers, :email, unique: true
  end
end
