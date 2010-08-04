class CreateNotificationsPlans < ActiveRecord::Migration
  def self.up
    create_table :notifications_plans do |t|
      t.references :plan
      t.references :notification
    end
    remove_column :notifications_plans, :id
  end

  def self.down
    drop_table(:notifications_plans)
  end
end
