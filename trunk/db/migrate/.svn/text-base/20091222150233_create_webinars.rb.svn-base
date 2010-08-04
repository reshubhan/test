class CreateWebinars < ActiveRecord::Migration
  def self.up
    create_table :webinars do |t|
      t.string :title
      t.string :speaker
      t.string :organization
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :webinars
  end
end
