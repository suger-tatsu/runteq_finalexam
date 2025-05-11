class CreateGroupAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :group_assignments do |t|
      t.string :title, null: false
      t.references :teacher, foreign_key: true
      t.timestamps
    end
  end
end
