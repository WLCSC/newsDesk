class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
