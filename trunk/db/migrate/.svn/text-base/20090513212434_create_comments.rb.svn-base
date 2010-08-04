class CreateComments < ActiveRecord::Migration
  def self.up
    create_table "comments" do |t|
      t.column :body,       :string, :null => false
      t.column :user_id,    :integer
      t.column :manager_id, :integer
      t.column :flag, :boolean
      t.column :ups_count, :integer
      t.column :downs_count, :integer
      t.timestamp
    end
  end

  def self.down
    drop_table :comments
  end
end
