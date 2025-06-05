class AddRememberDigestToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :remember_digest, :string
  end
end
