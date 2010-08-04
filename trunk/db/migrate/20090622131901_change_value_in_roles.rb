class ChangeValueInRoles < ActiveRecord::Migration
  def self.up
    Role.find_by_title('Institutional Invester').update_attribute('title', 'Institutional Investor')
  end

  def self.down
  end
end
