class AddPublicSharingToGroupAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :group_assignments, :public_token, :string
    add_column :group_assignments, :public_password_digest, :string

    add_index :group_assignments, :public_token, unique: true
  end
end
