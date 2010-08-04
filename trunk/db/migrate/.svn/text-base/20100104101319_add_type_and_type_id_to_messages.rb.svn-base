class AddTypeAndTypeIdToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :type, :string
    add_column :messages, :type_id, :integer
  end

  def self.down
    remove_column(:messages, :type)
    remove_column(:messages, :type_id)
  end
end
