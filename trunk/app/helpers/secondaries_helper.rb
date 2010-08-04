module SecondariesHelper

  def get_size_secondaries(type, asset, geography, nav, drawn, expected_price)
    joins = "inner join managers mgr on secondaries.manager_id = mgr.id inner join assets ast on mgr.asset_primary_id = ast.id
             inner join desired_sizes d on d.id = secondaries.nav left join assets ast2 on mgr.asset_secondary_id = ast2.id"
    conditions = "secondaries.status='approved'"
    type = type.blank? ? 'buy' : type

    #starting of conditions
    if asset && asset != 'Any'
      conditions += " AND (mgr.asset_primary_id = #{asset} OR mgr.asset_secondary_id = #{asset})"
    end
    if geography && geography != 'Any'
      conditions += " AND (mgr.geography_id = #{geography})"
    end
    if nav && nav != 'Any Size'
      conditions += " AND d.name = '#{nav}'"
    end
    if expected_price && expected_price != 'Any'
      conditions += " AND secondaries.expected_price = '#{expected_price}'"
    end
    if drawn && drawn != 'Any'
      conditions += " AND secondaries.drawn = '#{drawn}'"
    end
#    if manager_id && id
#      type = id
#      conditions += " AND secondaries.manager_id = '#{manager_id}' AND secondaries.secondary_type = '#{type}'"
#    else
      conditions += " AND secondaries.secondary_type = '#{type}'"
#    end
    puts conditions
    Secondary.count(:all, :joins => joins, :conditions => conditions)
  end
  
end
