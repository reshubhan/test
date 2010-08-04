class AddTypeToSecondaries < ActiveRecord::Migration
  def self.up
    add_column :secondaries, :classified_type, :string
    secondaries = Secondary.find_by_sql("select * from secondaries where classified_type is null")
    secondaries.each do |secondary|
      secondary.update_attribute('classified_type', 'secondary')
    end
  end

  def self.down
    remove_column :secondaries, :classified_type
  end
end
