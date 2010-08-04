class CreateClassifiedFunds < ActiveRecord::Migration
  def self.up
    create_table :classified_funds do |t|
      t.string :classified_fund_type
      t.integer :manager_id
      t.integer :user_id
      t.integer :approver_id
      t.datetime :approved_at
      t.string :status, :default => 'approved'
      t.text :description
      t.integer :created_by
      t.integer :updated_by
      t.string :desired_size
      t.string :position
      t.string :fund_size
      t.integer :geography_id
      t.integer :asset_id
      t.integer :asset_type_id
      t.timestamps
    end
    remove_column :secondaries, :classified_type
  end

  def self.down
    drop_table :classified_funds
    add_table :secondaries, :classified_type, :string
  end
end
