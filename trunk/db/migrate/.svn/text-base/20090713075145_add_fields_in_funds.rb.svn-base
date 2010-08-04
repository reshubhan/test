class AddFieldsInFunds < ActiveRecord::Migration
  def self.up
    remove_column :funds, :irr
    remove_column :funds, :multiple
    add_column :funds, :currency, :integer
    add_column :funds, :sector, :string
    add_column :funds, :investors, :string
    add_column :funds, :irr, :float
    add_column :funds, :multiple, :float
  end

  def self.down
    remove_column :funds, :currency, :integer
    remove_column :funds, :sector, :string
    remove_column :funds, :investors, :string
    remove_column :funds, :irr
    remove_column :funds, :multiple
    add_column :funds, :irr, :integer
    add_column :funds, :multiple, :integer
  end
end
