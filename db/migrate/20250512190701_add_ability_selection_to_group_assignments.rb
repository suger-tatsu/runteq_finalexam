class AddAbilitySelectionToGroupAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :group_assignments, :ability_selection, :jsonb
  end
end
