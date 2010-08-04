class ChangeColNameInEmail < ActiveRecord::Migration
  def self.up
    rename_column(:emails, :created_at, :created_on)
    rename_column(:emails, :updated_at, :updated_on)
  end

  def self.down
    rename_column(:emails, :created_on, :created_at)
    rename_column(:emails, :updated_on, :updated_at)
  end
end
