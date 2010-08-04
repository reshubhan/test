class CreateDesiredSizes < ActiveRecord::Migration
  def self.up
    create_table :desired_sizes do |t|
      t.string 'name'
      t.float 'size_in_billions'
    end
    DesiredSize.create(:name => '<$5M', :size_in_billions => 0.005)
    DesiredSize.create(:name => '$5M-20M', :size_in_billions => 0.02)
    DesiredSize.create(:name => '$20-50M', :size_in_billions => 0.05)
    DesiredSize.create(:name => '$50-100M', :size_in_billions => 0.1)
    DesiredSize.create(:name => '>$100M', :size_in_billions => 0.1)
    DesiredSize.create(:name => '>$20M', :size_in_billions => 0.02)
  end

  def self.down
    drop_table :desired_sizes
  end
end
