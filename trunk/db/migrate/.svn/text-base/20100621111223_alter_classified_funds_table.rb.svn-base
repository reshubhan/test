class AlterClassifiedFundsTable < ActiveRecord::Migration
  def self.up
    add_column :classified_funds, :desired_size_id, :integer
    add_index :classified_funds, :desired_size_id
    ClassifiedFund.find(:all).each do |cf|
#      cf.update_attribute(:desired_size_id, DesiredSize.find_by_name(cf.desired_size).id) unless cf.desired_size.blank?
      case(cf.desired_size)
        when '<$5M'
          cf.update_attribute(:desired_size_id, 1)
        when '$5M-20M'
          cf.update_attribute(:desired_size_id, 2)
        when '$20-50M'
          cf.update_attribute(:desired_size_id, 3)
        when '$50-100M'
          cf.update_attribute(:desired_size_id, 4)
        when '>$100M'
          cf.update_attribute(:desired_size_id, 5)
      end
    end
    remove_column :classified_funds, :desired_size
  end

  def self.down
    add_column :classified_funds, :desired_size, :string

    ClassifiedFund.find(:all).each do |cf|
      cf.update_attribute(:desired_size, cf.desired_size.name)
    end
    
    remove_column :classified_funds, :desired_size_id, :integer
    remove_index :classified_funds, :desired_size_id
  end
end
