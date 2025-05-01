class ChangeScienceAndArtsInStudents < ActiveRecord::Migration[8.0]
  def change
    remove_column :students, :science, :boolean
    remove_column :students, :arts, :boolean
    add_column :students, :science, :integer
    add_column :students, :humanities, :integer
  end
end
