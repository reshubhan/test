class AddColumnMultipleInFunds < ActiveRecord::Migration
  def self.up
    add_column :funds , :multiple ,:integer
  end

  def self.down
   remove_column :funds , :multiple
  end
end
