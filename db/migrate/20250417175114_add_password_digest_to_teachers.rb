class AddPasswordDigestToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :password_digest, :string
  end
end
