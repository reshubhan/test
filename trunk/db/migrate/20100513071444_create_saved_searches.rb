class CreateSavedSearches < ActiveRecord::Migration
  def self.up
    create_table :saved_searches do |t|
      t.string :search_type
      t.text :query
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :saved_searches
  end
end
