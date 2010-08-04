class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.string :name
      t.string :subject
      t.string :body

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
