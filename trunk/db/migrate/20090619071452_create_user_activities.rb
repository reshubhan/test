class CreateUserActivities < ActiveRecord::Migration
  def self.up
    create_table :user_activities do |t|
      t.column :user_id, :integer, :null => false
      t.column :activity, :string, :null => false
      t.column :regarding_type, :string, :null => false
      t.column :regarding_id, :string, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_activities
  end
end
