class AddNewAssetsForHedgeFundsInAssets < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      Asset.create(:name => "Active Trading", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Currency- Discretionary", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Commodity-Agriculture", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Commodity-Energy", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Commodity-Media", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Commodity-Multi", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Discretionary- Thematic", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Systematic- Diversified", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.create(:name => "Currency-Systemic", :created_by => 2, :parent_id => 58, :active_asset => true)
      Asset.find(87).update_attribute("active_asset", true)

      Asset.create(:name => "Activist", :created_by => 2, :parent_id => 57, :active_asset => true)
      Asset.create(:name => "Credit Arbitrage", :created_by => 2, :parent_id => 57, :active_asset => true)
      Asset.create(:name => "Distressed", :created_by => 2, :parent_id => 57, :active_asset => true)
      Asset.create(:name => "Merger Arbitrage", :created_by => 2, :parent_id => 57, :active_asset => true)
      Asset.create(:name => "Private Issue /Reg. D", :created_by => 2, :parent_id => 57, :active_asset => true)
      Asset.create(:name => "Special Situations", :created_by => 2, :parent_id => 57, :active_asset => true)
      Asset.create(:name => "Multi-Strategy", :created_by => 2, :parent_id => 57, :active_asset => true)

      Asset.find(56).update_attribute("name", "Equity Hedge")
      Asset.create(:name => "Equity Market Neutral", :created_by => 2, :parent_id => 56, :active_asset => true)
      Asset.create(:name => "Fundamental Growth", :created_by => 2, :parent_id => 56, :active_asset => true)
      Asset.create(:name => "Fundamental Value", :created_by => 2, :parent_id => 56, :active_asset => true)
      Asset.create(:name => "Quantitative Directional", :created_by => 2, :parent_id => 56, :active_asset => true)
      Asset.create(:name => "Short Bias", :created_by => 2, :parent_id => 56, :active_asset => true)
      Asset.create(:name => "Sector-Energy/Mat.", :created_by => 2, :parent_id => 56, :active_asset => true)
      Asset.create(:name => "Sector-IT/HC", :created_by => 2, :parent_id => 56, :active_asset => true)

      Asset.create(:name => "Fixed Income - Asset Backed", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Fixed Income - Convertible Arbitrage", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Fixed Income - Corporate", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Fixed Income - Soveriegn", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Volatility", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Yield Alternatives - Energy", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Yield Alternatives - Real Estate", :created_by => 2, :parent_id => 59, :active_asset => true)
      Asset.create(:name => "Multi-Stretegy", :created_by => 2, :parent_id => 59, :active_asset => true)

      Asset.find(:all, :conditions=>"name='Multi-Strategy'").each { |asset| asset.update_attribute("active_asset", true) }

    end
  end

  def self.down
  end
end
