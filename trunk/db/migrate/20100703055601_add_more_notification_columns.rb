class AddMoreNotificationColumns < ActiveRecord::Migration
  def self.up
    add_column :notifications, :allowed_to_choose, :boolean, :default => 0
    add_column :notifications, :status, :boolean, :default => 1
    add_column :notifications, :iteration, :integer
    add_column :notifications, :mailer_type, :integer
  end

  def self.down
    remove_column :notifications, :allowed_to_choose
    remove_column :notifications, :status
    remove_column :notifications, :iteration
    remove_column :notifications, :mailer_type
  end
end
