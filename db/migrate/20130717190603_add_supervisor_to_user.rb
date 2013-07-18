class AddSupervisorToUser < ActiveRecord::Migration
  def change
    add_column :users, :supervisor, :boolean
  end
end
