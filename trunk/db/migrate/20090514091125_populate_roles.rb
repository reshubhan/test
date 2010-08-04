class PopulateRoles < ActiveRecord::Migration
  def self.up
    Role.create(:title => 'Institutional Invester')
    Role.create(:title => 'Fund Manager')
    Role.create(:title => 'Service Provider')
    Role.create(:title => 'Admin')
  end

  def self.down
  end
end
