class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :data
      t.integer :user_id
      t.boolean :approved
      t.date :start
      t.date :end
      t.integer :organization_id

      t.timestamps
    end
  end
end
