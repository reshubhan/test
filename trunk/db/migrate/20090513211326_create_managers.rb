class CreateManagers < ActiveRecord::Migration
  def self.up
    create_table "managers", :force => true do |t|
      t.column :name, :string, :null => false
      t.column :url, :string, :null => false
      t.column :description, :text, :null => false
      t.column :geography_id, :integer, :null => false
      t.column :asset_primary_id, :integer, :null => false
      t.column :asset_secondary_id, :integer
      t.column :user_id, :integer, :null => false
      t.column :approver_id, :integer
      t.column :approved_at, :datetime
      t.column :status, :string
      t.timestamps
    end
  end

  def self.down
    drop_table "managers"
  end
end
