class AddGroupCountToGroupAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :group_assignments, :group_count, :integer
  end
end
