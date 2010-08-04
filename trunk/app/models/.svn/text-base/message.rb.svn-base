class Message < ActiveRecord::Base
  validates_presence_of :subject
  validates_presence_of :body
  belongs_to :sender, :class_name=>"User", :foreign_key=>"sender_id"
  belongs_to :receiver, :class_name=>"User", :foreign_key=>"reciever_id"
  belongs_to :manager, :class_name=>"Manager", :foreign_key=>"manager_id"

  def reciver_response
    is_not_interested ? "Not Interested" : (is_interested ? "Interested" : "Pending")
  end

  def short_subject
    subject.length>45 ? subject.slice(0,45)+"..." : subject
  end

  def short_name(name)
    name.length>20 ? name.slice(0,20)+"..." : name
  end
  
  def automatic_description_for_all_types(type,id)
    if type=="postings"
      posttype=ClassifiedFund.find_by_id(id)
    end
    if type=="company"
      posttype=Company.find_by_id(id)
    end
    if type=="secondary"
      posttype=Secondary.find_by_id(id)
    end
    if type=="postings"
      if !posttype.nil? && !posttype.user.nil? && !posttype.user.plan.blank? && !posttype.user.profile.organization_type.nil?
        name = posttype.user.profile.organization_type.name
      else if !posttype.nil? && !posttype.user.nil? && !posttype.user.plan.blank?
          name=posttype.user.plan.role.title
        end
      end
    else
      user=User.find_by_id(posttype.user_id)
      name=user.plan.role.title
    end
    if posttype.description.blank?
      if type!= "secondary"
        if posttype.desired_size
          des_size=posttype.desired_size.name
        else
          des_size="Any"
        end
       
        if posttype.asset_id
          asset=Asset.find_by_id(posttype.asset_id).name
        else
          asset="Any"
        end
        if posttype.asset_type_id
          asset_type=Asset.find_by_id(posttype.asset_type_id).name
        else
          asset_type="Any"
        end
      end
      if type!= "secondary" && type!= "company"
        if posttype.fund_size
          fundsize=posttype.fund_size
        else
          fundsize="Any"
        end
      end
      if type!= "secondary"
        if posttype.geography_id
          geo=Geography.find(posttype.geography_id).name
        else
          geo="Any"
        end
      end
      if type=="company"
        des=name +" is looking to invest "+des_size+" in "+ asset_type.to_s+"&nbsp;"+asset.to_s+" focused on "+ geo.to_s
      end
      if type=="secondary"
        des=name +" is looking to invest "+" with net asset value as "+posttype.net_asset_value.name+" with expected price as "+posttype.expected_price
      end
      if type=="postings"
        des=name +" is looking to invest "+des_size+" in "+"&nbsp;"+asset.to_s+" with fund size "+fundsize+" focused on "+ geo.to_s+"."
      end
      return des
    else
      des=posttype.description
    end
  end

end
