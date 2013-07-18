class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.boolean :administrator
      t.string :name
      t.string :email_address
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
