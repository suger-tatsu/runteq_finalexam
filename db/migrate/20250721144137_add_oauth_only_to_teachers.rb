class AddOauthOnlyToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :oauth_only, :boolean
  end
end
