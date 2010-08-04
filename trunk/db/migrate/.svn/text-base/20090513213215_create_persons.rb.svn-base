class CreatePersons < ActiveRecord::Migration
  def self.up
    create_table "persons" do |t|
      t.column :name,       :string, :null => false
      t.column :url,        :string, :null => false
      t.column :manager_id, :integer, :null => false
      t.column :approver_id,               :integer
      t.column :approved_at,               :datetime
      t.column :status,                    :string
      t.timestamp
     end
  end

  def self.down
    drop_table :persons
  end
end
