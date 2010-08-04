class ChangeColBodyInNotifications < ActiveRecord::Migration
  def self.up
    change_column :notifications, :body, :text
  end

  def self.down
    change_column :notifications, :body, :string
  end
end
