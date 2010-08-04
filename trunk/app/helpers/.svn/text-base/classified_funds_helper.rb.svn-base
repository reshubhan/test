module ClassifiedFundsHelper
  def get_description(id,type)
    ClassifiedFund.find(:first, :conditions => ["fund_id=? AND classified_fund_type=?", id,type]).description
  end

  def progress_image()
    unit = 1
    percent = 25
    unless ClassifiedFund.find(:first, :conditions => "user_id = #{current_user.id}").blank?
      unit=unit+1
    end
    unless Company.find(:first, :conditions => "user_id = #{current_user.id}").blank?
      unit=unit+1
    end
    unless Answer.find(:first, :conditions => "user_id = #{current_user.id}").blank?
      unit=unit+1
    end
    "<img src='/images/pro_#{percent*unit}.png'/>"
  end

  def assets_for_preference_fund
    Asset.find(:all,:conditions => " name IN ('Private Equity','Hedge Funds','Real Estate') AND parent_id IS NULL")
  end

  def get_size_funds(type, asset_class, asset_type, institution, geography, desired_size, fund_size)
    joins = "inner join users u on u.id = classified_funds.user_id inner join desired_sizes d on d.id = classified_funds.desired_size_id"
    conditions = "classified_funds.classified_fund_type = '#{type}' AND classified_funds.status='approved' AND u.status ='approved'"
    if institution && institution != 'Any'
      joins += " inner join profiles p on p.user_id = u.id"
      conditions += " AND p.organization_type_id = #{institution}"
    end
    if type.eql?'sell'
      joins += " inner join managers m on m.id = classified_funds.manager_id"
      if geography && geography != 'Any'
        conditions += " AND m.geography_id = #{geography}"
      end
      if asset_class &&  asset_class != 'Any'
        conditions += " AND m.asset_primary_id = #{asset_class}"
      end
      if asset_type &&  asset_type != 'Any'
        conditions += " AND m.asset_secondary_id = #{asset_type}"
      end
      if fund_size && fund_size != 'Any Size'
        joins += " inner join funds f on f.id = classified_funds.fund_id"
        conditions += ClassifiedFund.get_fund_sub_query(fund_size)
      end
    else
      if geography && geography != 'Any'
        conditions += " AND classified_funds.geography_id = #{geography}"
      end
      if asset_class &&  asset_class != 'Any'
        conditions += " AND classified_funds.asset_id = #{asset_class}"
      end
      if asset_type &&  asset_type != 'Any'
        conditions += " AND classified_funds.asset_type_id = #{asset_type}"
      end
      if desired_size && desired_size != 'Any Size'
        conditions += " AND d.name = '#{desired_size}'"
      end
      if fund_size && fund_size != 'Any Size'
        conditions += " AND classified_funds.fund_size = '#{fund_size}'"
      end
    end
    ClassifiedFund.count(:all, :joins => joins, :conditions => conditions)
  end

  def new_fund_display_name(user, fund)
    if user.show_user_name && fund.user.profile.organization_name
      fund.user.profile.organization_name
    elsif fund.user.profile.organization_type
      fund.user.profile.organization_type.name
    else
      fund.user.plan.role.title
    end
  end
  
end