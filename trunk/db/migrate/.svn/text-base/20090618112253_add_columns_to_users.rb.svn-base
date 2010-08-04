class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :emails, :integer, :default => 0
    add_column :users, :replies, :integer, :default => 0
    add_column :users, :views, :integer, :default => 0
    
    User.find(:all).each do |user|
      if user.plan
        case user.plan.name
          when 'Basic'
            user.emails = 0
            user.replies = 0
            user.views = 30
          when 'Plus'
            user.emails = 5
            user.replies = 25
            user.views = -1
          when 'Premium'
            user.emails = -1
            user.replies = -1
            user.views = -1
        end
        user.save
      end
    end
  end

  def self.down
    remove_column :users, :emails
    remove_column :users, :replies
    remove_column :users, :views
  end
end
