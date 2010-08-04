class RemoveProfileIdFromOrganizationTypes < ActiveRecord::Migration
  def self.up
    remove_column(:organization_types, :profile_id)
  end

  def self.down
    add_column :organization_types, :profile_id, :integer
  end
end
