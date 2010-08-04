class CreateManagerAttributes < ActiveRecord::Migration
  def self.up
  create_table "manager_attributes" do |t|
      t.column :attribute_id,      :integer, :null => false
      t.column :user_id,           :integer, :null => false
      t.column :manager_id,        :string , :null => false
    end
  end

  def self.down
     drop_table :manager_attributes
  end
end
