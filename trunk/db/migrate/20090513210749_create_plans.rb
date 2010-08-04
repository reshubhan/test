class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table "plans", :force => true do |t|
      t.column :name, :string, :null => false
      t.column :fee, :integer
      t.column :duration, :integer
      t.column :subscription_type, :string
      t.column :role_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table "plans"
  end
end
