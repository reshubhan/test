class CreateFunds < ActiveRecord::Migration
  def self.up
    create_table "funds" do |t|
      t.column :name, :string, :null => false
      t.column :size, :integer, :null => false
      t.column :year, :integer, :null => false
      t.column :overview, :string, :null => false
      t.column :irr, :string
      t.column :portfolio, :string, :null => false
      t.column :manager_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :approver_id, :integer
      t.column :approved_at, :datetime
      t.column :status, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :funds
  end
end
