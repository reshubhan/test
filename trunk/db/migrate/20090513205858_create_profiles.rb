class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table "profiles", :force => true do |t|
      t.column :firstname, :string, :limit => 40, :null => false
      t.column :lastname, :string, :limit => 40, :null => false
      t.column :job_title, :string, :limit => 100
      t.column :email, :string, :limit => 255, :null => false
      t.column :organization_name, :string, :limit => 100
      t.column :zip, :string
      t.column :user_id, :integer
      t.column :approver_id, :integer
      t.column :approved_at, :datetime
      t.column :approved, :boolean
      t.timestamps
    end
  end

  def self.down
    drop_table "profiles"
  end
end
