desc "creating default postings"

task :create_default_postings => :environment do
  assetObj = ENV["ASSET_NAME"]
  token = ENV["TOKEN"]
  current_user = User.find(ENV["USER_ID"])
  case (assetObj)
  when "hedge"
    assetObj="Hedge Funds"
  when "real"
    assetObj="Real Estate"
  when "private"
    assetObj="Private Equity"
  end
  flag=false
  case (assetObj)
  when "Hedge Funds"
    @assets=Asset.find(:all,:conditions =>"name in ('Hedge Funds') and parent_id is null", :include => [:subassets] )
  when "Real Estate"
    @assets=Asset.find(:all,:conditions => "name in ('Real Estate','Natural Resources','Infrastructure')", :include => [:subassets])
  when "Private Equity"
    @assets = Asset.find(:all,:conditions => "name not in ('Natural Resources','Infrastructure','Real Assets','Real Estate','Hedge Funds','Credit') and parent_id is null", :include => [:subassets])
  end
  sectors = Sector.all
  geographies = Geography.find(:all,:conditions =>"name in ('Us')")
  fundsizes = ['Any']
  desiredsize = DesiredSize.find(:first, :conditions => "name = '$5M-20M'")
  ActiveRecord::Base.transaction do
    @assets.each do |asset|
      geographies.each do |geography|
        unless asset.subassets.blank?
          asset.subassets.each do |subasset|
            if asset.name=="Hedge Funds"
              unless subasset.subassets.blank?
                subasset.subassets.each do |lowersubasset|
                  classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography.id,:asset_id=>asset.id,:asset_type_id => lowersubasset.id,:fund_size=>fundsizes.to_s,:desired_size_id=>desiredsize.id,:classified_fund_type=>"buy",:user_id=>current_user.id)
                  classified_fund.sectors = sectors
                  classified_fund.creator = current_user
                  classified_fund.save!
                end
              else
                classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography.id,:asset_id=>asset.id,:fund_size=>fundsizes.to_s,:desired_size_id=>desiredsize.id,:classified_fund_type=>"buy",:user_id=>current_user.id)
                classified_fund.sectors = sectors
                classified_fund.creator = current_user
                classified_fund.save!
              end
            else
              classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography.id,:asset_id=>asset.id,:asset_type_id => subasset.id,:fund_size=>fundsizes.to_s,:desired_size_id=>desiredsize.id,:classified_fund_type=>"buy",:user_id=>current_user.id)
              classified_fund.sectors = sectors
              classified_fund.creator = current_user
              classified_fund.creator = current_user
              classified_fund.save!
            end
          end
        else
          classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography.id,:asset_id=>asset.id,:fund_size=>(fundsizes.to_s),:desired_size_id=>desiredsize.id,:classified_fund_type=>"buy",:user_id=>current_user.id)
          classified_fund.sectors = sectors
          classified_fund.creator = current_user
          classified_fund.save!
        end
      end
      flag=true
    end
    if ! flag
      "Some problem occured during creation of posting for #{assetObj}, please try again."
    else
      ""
    end
  end
end