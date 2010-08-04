class CreateNotificationsUsers < ActiveRecord::Migration
  def self.up
    create_table :notifications_users do |t|
      t.references :user
      t.references :notification
    end
    remove_column :notifications_users, :id
  end

  def self.down
    drop_table(:notifications_users)
  end
end
