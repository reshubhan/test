class FacebookController < ApplicationController
  before_filter :ensure_authenticated_to_facebook
  
  def invite_friends
  end

  def connect
    @fb_user = session[:facebook_session].user
    render(:update) do |page|
      page.hide :fb_section
      if !current_user.nil?
        user  = User.find(current_user.id )
        if user.facebook_user.blank?
          user.facebook_user = FacebookUser.create("user_id" => user.id, "facebook_user_id" => @fb_user.to_i, "image_url" => @fb_user.pic_square_with_logo)
          user.save
          #page.call "connect_user", @fb_user.name
        else
          user.facebook_user.update_attribute("image_url", @fb_user.pic_square_with_logo)
        end
      end
      if params[:id]=='setting'
        page.replace_html :fb_setting_content, :partial => 'users/fb_settings'
        #page.replace_html :fb_friend_content, :partial => 'users/fb_friend_list'
        page.show :friend_div
        page.hide :login_div
      else
        page.reload
      end
    end
  end

  def disconnect
    user = User.find(current_user.id)
    if user
      user.facebook_user=nil
      user.save
      #      session['USER'] = user
    end
    #redirect_to "/user/settings"
    redirect_to user_profile_path
  end

  def sent_invite
    if params.has_key?("ids")
      friend_invites = params[:ids]
      friend_invites.each do |friend_id|
        Invites.create(:user_id=> current_user.id, :receipient_email_id => friend_id.to_s, :invite_type => 'facebook', :status => 0) unless Invites.exists?(:user_id => current_user.id.to_s, :receipient_email_id => friend_id.to_s )
      end
    end
    redirect_to user_profile_path
  end

  def accept_invite
    invitee= params[:id]
    if params.has_key?("session")
      acceptance_string= params[:session]
      acceptance_string.gsub!(/\{/,"")
      acceptance_string.gsub!(/\}/,"")
      acceptance_string.gsub!(/\"/,"")
      arr= acceptance_string.split(",")
      i=0
      arr.each do |ar|
        arr[i]= ar.split(":")
        i= i+1
      end
      invite= Invites.find(:first, :conditions=> ["user_id=? and invite_type=? and receipient_email_id=?",invitee.to_s,'facebook', arr[1][1].to_s ])
      invite.status=1
      invite.save
    else
      #uid= session[:facebook_session].uid
      set_facebook_session
      uid = @facebook_session.user.uid
      invite= Invites.find(:first, :conditions=> ["user_id=? and invite_type=? and receipient_email_id=?",invitee.to_s,'facebook', uid.to_s ])
      invite.status=1
      invite.save
    end
    redirect_to user_profile_path
  end
end