class Plan  < ActiveRecord::Base
  has_many :users
  has_many :orders
  belongs_to :role

  def check_plus
   
    if status==true
    if rank==2 or rank==4
      "checked='true'"
    else
      ""
    end
    else
      if rank==2 or rank==3 or rank==10 or rank==11
      "checked='true'"
    else
      ""
    end
    end
    
  end

  def check_premium
    if status==true
    if rank==3 or rank==5
      "checked='true'"
    else
      ""
    end
    else
     if rank==4 
      "checked='true'"
    else
      ""
    end
    end
  end

  def check_year
    if status==true
    if rank==4 or rank==5
      "checked='true'"
    else
      ""
    end
    else

    end
  end

  def check_normal
    if rank==2 or rank==3
      "checked='true'"
    else
      ""
    end
  end

  def detail
    self.role.title + ' : ' + self.name + (self.duration.blank? ? '' : ' : ' + self.duration) + (self.status ? '' : '[old]')
  end
  
  def self.membership_plan( type,user)
#      if duration=="yearly"
#        if type=="premium"
#          @plan=Plan.find(:first,:conditions=>{:name=>'Premium Annual',:role_id=>user.plan.role.id})
#        else
#          @plan=Plan.find(:first,:conditions=>{:name=>'Plus Annual',:role_id=>user.plan.role.id})
#        end
#      else if duration=="monthly" && type=="premium"
#          @plan=Plan.find(:first,:conditions=>{:name=>'Premium Monthly',:role_id=>user.plan.role.id})
#        else
#          @plan=Plan.find(:first,:conditions=>{:name=>'Plus Monthly',:role_id=>user.plan.role.id})
#        end
#      end
     if type=='plus'
       @plan=Plan.find(:first,:conditions=>{:name=>'Plus Annual',:role_id=>user.plan.role.id})
     else
       @plan=Plan.find(:first,:conditions=>{:name=>'Premium Annual',:role_id=>user.plan.role.id})
     end
  end
end
