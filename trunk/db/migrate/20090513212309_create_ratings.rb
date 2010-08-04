class CreateRatings < ActiveRecord::Migration
  def self.up
     create_table :ratings do |t|
      t.column :performance,:integer
      t.column :team,       :integer
      t.column :strategy,   :integer
      t.column :terms,      :integer
      t.column :overall,    :integer
      t.column :user_id,    :integer, :null => false
      t.column :manager_id, :integer, :null => false
      t.timestamp
    end
  end

  def self.down
    drop_table :ratings
  end
end
