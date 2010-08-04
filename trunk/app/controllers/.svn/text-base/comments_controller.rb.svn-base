class CommentsController < ApplicationController
  layout "admin", :except => [:show]
  access_control [:index] => 'admin'
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.paginate :page => params[:page], :per_page => 25, :conditions => {:flag => true}
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  def add_flag
    @comment = Comment.find(params[:id])
    @comment.update_attribute(:flag, @comment.flag ? false : true)
    render(:update) do |page|
      flag_div = "flag_" + params[:id].to_s
      flag_info_div = "flag_info_" + params[:id].to_s
      page.replace_html flag_div, link_to_remote(@comment.flag ? image_tag("/images/flag_manager_glow.jpg", :size => "20x20") : image_tag("/images/flag_manager.jpg", :size => "20x20")), :url => {:controller=>'comments', :action => "add_flag", :id => @comment.id } 
      if @comment.flag
        page.replace_html flag_info_div, "*The comment has been flagged."
      else
        page.replace_html flag_info_div, " "
      end
    end
  end

  #  def add_thumbsup
  #    @comment = Comment.find(params[:id])
  #    @comment.ups_count.blank? ? @comment.ups_count=1 : @comment.ups_count +=1
  #    @comment.save
  #    render(:update) do |page|
  #      div_id = "up_count_" + @comment.id.to_s
  #      page.replace_html div_id, @comment.ups_count.to_s
  #    end
  #  end
  #
  #  def add_thumbsdown
  #    @comment = Comment.find(params[:id])
  #    @comment.downs_count.blank? ? @comment.downs_count=1 : @comment.downs_count +=1
  #    @comment.update_attribute(:downs_count, @comment.downs_count)
  #    render(:update) do |page|
  #      div_id = "down_count_" + @comment.id.to_s
  #      page.replace_html div_id, @comment.downs_count.to_s
  #    end
  #  end
  
  def rate_comment
    begin
      comment = Comment.find(params[:id])
      unless comment.user.login==current_user.login
        @old_comment_rating = CommentRatings.find(:first, :conditions => "comment_id = #{params[:id]} and user_id = #{current_user.id}")
        if @old_comment_rating.blank?
          @comment_rating = CommentRatings.create(:comment_id => params[:id].to_i, :user_id => current_user.id, :rate => params[:rate])
        else
          @old_comment_rating.rate = params[:rate]
          @old_comment_rating.save
        end
      end
      render(:update) do |page|
        div_down = "down_count_" + params[:id].to_s
        page.replace_html div_down, CommentRatings.find(:all, :conditions => "comment_id = #{params[:id]} and rate = 'down'").size.to_s
        div_up = "up_count_" + params[:id].to_s
        page.replace_html div_up, CommentRatings.find(:all, :conditions => "comment_id = #{params[:id]} and rate = 'up'").size.to_s
      end
    rescue
      render(:update) do |page|
        div_down = "down_count_" + params[:id].to_s
        page.replace_html div_down, $!.inspect
      end
    end
  end
  
  def approve_flagged_comment
    @comment = Comment.find(params[:id])
    @comment.status = 'disapproved'
    @comment.save
    flash[:message] = 'Comment approved successfully'
    redirect_to :action => "index"
  end

  def disapprove_flagged_comment
    @comment = Comment.find(params[:id])
    @comment.status = 'approved'
    @comment.flag = false
    @comment.save
    flash[:message] = 'Comment disapproved successfully'
    redirect_to :action => "index"
  end
end
