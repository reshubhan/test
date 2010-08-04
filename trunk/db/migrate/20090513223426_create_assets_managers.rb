class CreateAssetsManagers < ActiveRecord::Migration
  def self.up
    create_table "assets_managers", :force => true do |t|
      t.column :asset_is,   :integer
      t.column :manager_id,               :integer
      t.timestamps
    end
  end

  def self.down
    drop_table "assets_managers"
  end
end
