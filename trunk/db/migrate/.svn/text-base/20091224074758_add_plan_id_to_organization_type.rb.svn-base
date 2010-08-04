class AddPlanIdToOrganizationType < ActiveRecord::Migration
  def self.up
    add_column :organization_types, :plan_id, :integer
  end

  def self.down
    remove_column(:organization_types, :plan_id)
  end
end
