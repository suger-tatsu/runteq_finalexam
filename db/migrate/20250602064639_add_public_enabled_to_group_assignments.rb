class AddPublicEnabledToGroupAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :group_assignments, :public_enabled, :boolean, default: false
  end
end
