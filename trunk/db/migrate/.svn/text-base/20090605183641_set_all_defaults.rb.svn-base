class SetAllDefaults < ActiveRecord::Migration
  def self.up
    change_column_default(:funds, :status, "unapproved")
    change_column_default(:managers, :status, "unapproved")
    change_column_default(:persons, :status, "unapproved")
    change_column_default(:profiles, :approved, 0)
    change_column_default(:secondaries, :status, "unapproved")
    change_column_default(:users, :status, "unapproved")
  end

  def self.down
  end
end
