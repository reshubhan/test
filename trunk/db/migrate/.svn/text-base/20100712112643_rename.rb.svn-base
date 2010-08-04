class Rename < ActiveRecord::Migration
  def self.up
    rename_column(:invites, :type, :invite_type)
  end

  def self.down
    rename_column(:invites, :invite_type, :type)
  end
end
