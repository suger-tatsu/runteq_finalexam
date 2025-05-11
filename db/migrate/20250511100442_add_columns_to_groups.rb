class AddColumnsToGroups < ActiveRecord::Migration[8.0]
  def change
    add_column :groups, :name, :string

    add_reference :groups, :group_assignment, foreign_key: true
  end
end
