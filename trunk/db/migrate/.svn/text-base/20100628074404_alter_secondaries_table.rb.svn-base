class AlterSecondariesTable < ActiveRecord::Migration
  def self.up
    add_column :secondaries, :nav, :integer
    add_index :secondaries, :nav
    Secondary.find(:all).each do |s|
#      s.update_attribute(:nav, DesiredSize.find_by_name(s.net_asset_value).id) unless s.net_asset_value.blank?
       case(s.net_asset_value)
        when '<$5M'
          s.update_attribute(:nav, 1)
        when '$5M-20M'
          s.update_attribute(:nav, 2)
        when '>$20M'
          s.update_attribute(:nav, 6)
      end
    end
    remove_column :secondaries, :net_asset_value
  end

  def self.down
    add_column :secondaries, :net_asset_value, :string

    Secondary.find(:all).each do |s|
      s.update_attribute(:net_asset_value, s.net_asset_value.name)
    end

    remove_column :secondaries, :nav
    remove_index :secondaries, :nav
  end
end
