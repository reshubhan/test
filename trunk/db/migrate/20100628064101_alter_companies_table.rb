class AlterCompaniesTable < ActiveRecord::Migration
  def self.up
    add_column :companies, :desired_size_id, :integer
    add_index :companies, :desired_size_id
    Company.find(:all).each do |c|
#      c.update_attribute(:desired_size_id, DesiredSize.find_by_name(c.desired_size).id) unless c.desired_size.blank?
      case(c.desired_size)
        when '<$5M'
          c.update_attribute(:desired_size_id, 1)
        when '$5M-20M'
          c.update_attribute(:desired_size_id, 2)
        when '$20M-50M'
          c.update_attribute(:desired_size_id, 3)
        when '$50M-100M'
          c.update_attribute(:desired_size_id, 4)
        when '>$100M'
          c.update_attribute(:desired_size_id, 5)
      end
    end
    remove_column :companies, :desired_size
  end

  def self.down
    add_column :companies, :desired_size, :string

    Company.find(:all).each do |c|
      c.update_attribute(:desired_size, c.desired_size.name)
    end

    remove_column :companies, :desired_size_id, :integer
    remove_index :companies, :desired_size_id
  end
end
