class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :url
      t.string :company_type 
      t.float :revenue_per_year
      t.integer :currency
      t.boolean :new_financing
      t.string :desired_size
      t.integer :geography_id
      t.string :type_of_financing
      t.string :posted_by
      t.text :description
      t.integer :asset_id
      t.string :status, :default => 'approved'
      t.integer :user_id
      t.integer :updated_by
      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
