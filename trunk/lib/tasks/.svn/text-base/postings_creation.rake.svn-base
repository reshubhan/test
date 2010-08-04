desc "creating_postings"

task :create_postings => :environment do
  params = YAML::load(SessionData.find(ENV["ID"]).data)
  current_user = User.find(ENV["USER_ID"])
  token = ENV["TOKEN"]
  error=[]
  flag=false
  email_check_in_description=false
  assets = Asset.find(params[:assets], :include => [:subassets]) if params[:assets]
  geographies = Geography.find(:all,:conditions =>"name in ('Us','Asia')",:select=>'id').map {|x| x.id}
  fundsizes = ['Any']
  sectors = Sector.all
  desiredsize = 2
  assettypes = []
  assets.each do |asset|
    if params[:classified_fund]['asset'+asset.id.to_s][:geo].include?("Let me choose")
      params[:classified_fund]['asset'+asset.id.to_s][:geo].delete("Let me choose")
      geographies = params[:classified_fund]['asset'+asset.id.to_s][:geo]
    end
    if params[:classified_fund]['asset'+asset.id.to_s][:fund_size].include?("Let me choose")
      params[:classified_fund]['asset'+asset.id.to_s][:fund_size].delete("Let me choose")
      fundsizes = params[:classified_fund]['asset'+asset.id.to_s][:fund_size]
    end
    if params[:classified_fund]['asset'+asset.id.to_s][:sector].include?("Let me choose")
      params[:classified_fund]['asset'+asset.id.to_s][:sector].delete("Let me choose")
      sectors = Sector.find(params[:classified_fund]['asset'+asset.id.to_s][:sector])
    end
    if params[:classified_fund]['asset'+asset.id.to_s][:desired_size]
      desiredsize = params[:classified_fund]['asset'+asset.id.to_s][:desired_size]
    end
    if asset.name=="Hedge Funds"
      params[:classified_fund]['asset'+asset.id.to_s][:assettypes].each do |type|
        if params[:classified_fund]['asset'+asset.id.to_s]['subtype'+type].size>1
          if params[:classified_fund]['asset'+asset.id.to_s]['subtype'+type].include?("Let me choose")
            params[:classified_fund]['asset'+asset.id.to_s]['subtype'+type].delete("Let me choose")
            params[:classified_fund]['asset'+asset.id.to_s]['subtype'+type].each do |subtype|
              assettypes << subtype
            end
          else
            assetype = Asset.find(type, :include => [:subassets])
            assetype.subassets.each do |subasset|
              assettypes << subasset.id
            end
          end
        else
          assettypes << nil
        end
      end
    else
      if params[:classified_fund]['asset'+asset.id.to_s][:assettypes].size>1
        if params[:classified_fund]['asset'+asset.id.to_s][:assettypes].include?("Let me choose")
          params[:classified_fund]['asset'+asset.id.to_s][:assettypes].delete("Let me choose")
          assettypes = params[:classified_fund]['asset'+asset.id.to_s][:assettypes]
        else
          asset.subassets.each do |subasset|
            assettypes << subasset.id
          end
        end
      else
        assettypes << nil
      end
    end
    ActiveRecord::Base.transaction do
      geographies.each do |geography|
        fundsizes.each do |fundsize|
          unless assettypes.blank?
            assettypes.each do |assettype|
              if assettype.nil?
                classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography,:asset_id=>asset.id,:asset_type_id => assettype,:fund_size=>fundsize,:desired_size_id=>desiredsize,:classified_fund_type=>"buy",:user_id=>current_user.id)
              else
                classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography,:asset_id=>asset.id,:fund_size=>fundsize,:desired_size_id=>desiredsize,:classified_fund_type=>"buy",:user_id=>current_user.id)
              end
              classified_fund.sectors = sectors
              classified_fund.description = params[:description] if params[:description]
              classified_fund.creator = current_user
              classified_fund.save!
            end
          else
            classified_fund=ClassifiedFund.new(:token=>token,:geography_id=>geography,:asset_id=>asset.id,:fund_size=>fundsize,:desired_size_id=>desiredsize,:classified_fund_type=>"buy",:user_id=>current_user.id)
            classified_fund.sectors = sectors
            classified_fund.description = params[:description] if params[:description]
            classified_fund.creator = current_user
            classified_fund.save!
          end
        end
      end
      email_found = params[:description].match( /([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/)
      params[:description] = params[:description].gsub( /([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/, "Email_id")
      if params[:description] && email_found && (email_check_in_description==false)
        puts "Email/s found in decription, Sending warning message to admin..."
        Mailer.deliver_email_alert_mail(current_user.profile.fullname,current_user.login,"Postings")
        email_check_in_description=true
      end
      flag=true
    end
    error << "Some problem occured during creation of posting for #{asset.name}, please try again." unless flag
    flag = false
    assettypes.clear
  end
  error.join(",\n")
end