class CreateSecondaries < ActiveRecord::Migration
  def self.up
    create_table "secondaries" do |t|
      t.column :secondary_type, :string, :null => false
      t.column :description, :string, :null => false
      t.column :manager_id, :integer, :null => false
      t.column :commitment_size, :integer
      t.column :net_asset_value, :integer
      t.column :drawn, :integer
      t.column :vintage, :integer
      t.column :par, :boolean
      t.column :discount, :integer
      t.column :premium, :integer
      t.column :description, :text
      t.column :approver_id, :integer
      t.column :approved_at, :datetime
      t.column :status, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :secondaries
  end
end
