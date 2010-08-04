module CompaniesHelper

  def assets_for_preference_company
    Asset.find(:all,:conditions => " name IN ('Distressed','Buyout','Real Estate', 'Venture Capital') AND parent_id IS NULL")
  end

  def get_size_companies(type, financing, geography, desired_size, asset, asset_type, sector)
    type = type.blank? ? 'buy' : type
    joins = "inner join desired_sizes d on d.id = companies.desired_size_id"
    conditions = "status='approved' AND company_type= '#{type}'"

    if financing && financing != 'Any'
      conditions += " AND type_of_financing = '#{financing}'"
    end
    if geography && geography != 'Any'
      conditions += " AND geography_id = '#{geography}'"
    end
    if desired_size && desired_size != 'Any Size'
      conditions += " AND d.name = '#{desired_size}'"
    end
    if asset && asset != 'Any'
      conditions += " AND asset_id = '#{asset}'"
    end
    if asset_type &&  asset_type != 'Any'
      conditions += " AND asset_type_id = '#{asset_type}'"
    end
    if sector && sector != 'Any'
      joins += " inner join companies_sectors cs on cs.company_id = companies.id"
      conditions += " AND cs.sector_id = '#{sector}'"
    end

    Company.count(:all, :joins => joins, :conditions => conditions)
  end

  def company_display_name(user, company)
    if user.show_user_name && company.user.profile.organization_name
      company.user.profile.organization_name
    elsif company.user.profile.organization_type
      company.user.profile.organization_type.name
    else
      "Some organization"
    end
  end

end

