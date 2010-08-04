class CreateFundSizes < ActiveRecord::Migration
  def self.up
    create_table :fund_sizes do |t|
      t.string 'name'
      t.float 'size_in_billions'
    end
    FundSize.create(:name => '<$100M', :size_in_billions => 0.1)
    FundSize.create(:name => '$100M-250M', :size_in_billions => 0.25)
    FundSize.create(:name => '$250M-500M', :size_in_billions => 0.5)
    FundSize.create(:name => '$500M-1B', :size_in_billions => 1.0)
    FundSize.create(:name => '$1B-$5B', :size_in_billions => 5.0)
    FundSize.create(:name => '>$5B', :size_in_billions => 5.0)
  end

  def self.down
    drop_table :fund_sizes
  end
end
