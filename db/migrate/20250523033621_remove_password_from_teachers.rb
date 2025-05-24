class RemovePasswordFromTeachers < ActiveRecord::Migration[8.0]
  def change
    remove_column :teachers, :password, :string
  end
end
