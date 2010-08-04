class AddTelephoneAndOrganizationTypeToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :telephone, :integer
    add_column :profiles, :organization_type_id, :integer
  end

  def self.down
    remove_column :profiles, :telephone
    remove_column :profiles, :organization_type_id
  end
end
