class CreateGroupSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :group_skills do |t|
      t.references :group, foreign_key: true  # グループID
      t.string :skill  # グループ
      t.timestamps
    end
  end
end
