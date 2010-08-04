class QuestionsController < ApplicationController
  before_filter :login_required
  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'

  layout :ticker_layout

  def ticker_layout
    if current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end

  def index
    @count=Question.count(:all,:conditions =>{:status => true})
    if current_user.has_role('Admin')
      @questions = Question.find(:all)
    else
      @questions = Question.find(:all,:conditions=>{:role=>current_user.plan.role.id,:status=>true})
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  def show_question
    question=Question.find_by_id(params[:id])
    question.update_attribute(:status, true)
    flash[:notice] = 'Question was Added to show question list.'
    redirect_to :action=>"index",:controller=>"questions"
  end

  def remove_question
    question=Question.find_by_id(params[:id])
    question.update_attribute(:status, false)
    flash[:notice] = 'Question was removed form the show question list.'
    redirect_to :action=>"index",:controller=>"questions"
  end

  def list_question
    if Question.find_by_sql("select * from questions q inner join questions_roles qr on q.id=qr.question_id where qr.role_id=#{current_user.plan.role.id} and q.status=true").blank?
      redirect_to :controller=>"classified_funds",:action=>"index"
    else
    end
  end

  def list_answers
  end

  def new_rank
    q1=Question.find(:first,:conditions =>{:rank =>params[:new_rank]})
    q2=Question.find(:first,:conditions =>{:rank =>params[:old_rank]})
    q1.update_attribute(:rank,params[:old_rank].to_i)
    q2.update_attribute(:rank,params[:new_rank].to_i)
    render(:update) do |page|
      @count=Question.count(:all,:conditions =>{:status => true})
      @questions = Question.find(:all,:conditions =>{:status => true})
      page.replace_html "results", :partial => "results"
    end
  end

  def add_field
    @num=rand(10000)
    render(:update) do |page|
      page.insert_html :bottom,'more_options', :partial => 'new_field'
    end
  end

  def add_radio_field
    @num=Time.now.to_i.to_s
    render(:update) do |page|
      page.insert_html :bottom,'more_options', :partial => 'layouts/radio_new_field'
    end
  end

  def edit_add_field
    @num=Time.now.to_i.to_s
    render(:update) do |page|
      page.insert_html :before,'new_radio_field', :partial => 'layouts/edit_add_field'
    end
  end

  def question_type
    @num=Time.now.to_i.to_s
    session[:check] = 0
    render(:update) do |page|
      if params[:value]=="yes/no with option"
        if session[:check] == 1
          page.replace_html 'new_field', :partial => 'layouts/question_type'
        else
          page.replace_html 'new_field1', :partial => 'layouts/question_type'
        end
      elsif params[:value]=="yes/no without option"
        if session[:check] == 1
          page.replace_html 'new_field', :partial => 'layouts/yes_no_without_option'
        else
          page.replace_html 'new_field1', :partial => 'layouts/yes_no_without_option'
        end
      elsif params[:value]=="multiple choice"
        if session[:check] == 1
          page.replace_html 'new_field', :partial => 'layouts/new_field'
        else
          page.replace_html 'new_field1', :partial => 'layouts/new_field'
        end
      else
        session[:check] = 1
        page.replace_html 'new_field1', :partial => 'layouts/text_field'
      end
    end
  end

  def more_options
    render(:update) do |page|
      page.replace_html  'more_options', :partial => 'layouts/more_options'
    end
  end

  def show_options
    option_value = params[:value].to_i
    @choices=Option.find(:all,:conditions=>"question_id=#{params[:value]} and parent_id is not NULL")
    render :update do |page|
      # page.show "radio_option_#{option_value}"
      page.replace_html "radio_option_#{option_value}", :partial => 'layouts/radio_options', :locals => {:choices => @choices}
    end
  end

  def new
    if  @status==true
      @question
    else
      @question = Question.new
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @options=Option.find(:all,:conditions=>{:question_id=>params[:id]})
  end

  def create
    @count=Question.count(:all,:conditions =>{:status => true})
    flag = false
    begin
      ActiveRecord::Base.transaction do
        @question = Question.new(:questions => params[:question][:questions],:rank =>@count+1, :question_type => params[:question][:question_type], :answer_text => params[:question][:answer_text])
        @question.role_ids=params[:question][:role]
        if ((@question.question_type=='multiple choice' or @question.question_type=='yes/no with option') and params[:question][:option])
          if @question.question_type=='yes/no with option'
            yes_option = Option.create(:option => "option_yes")
            no_option = Option.create(:option => "option_no")
            @question.options << yes_option
            @question.options << no_option
            params[:question][:option].each do |option|
              @question.options << Option.create(:option => option, :parent_id => yes_option.id)
            end
          else
            params[:question][:option].each do |option|
              @question.options << Option.create(:option => option)
            end
          end
        end
        @question.save!
        flag=true
      end
    rescue Exception => exp
      flag=false
    end
    if flag
      @questions = Question.find(:all, :conditions => "status=1")
      redirect_to questions_path
    else
      render :action => "new"
    end
  end

  def update
    flag = false
    status=false
    options = []
     @question = Question.find(params[:question][:id])
    unless params[:question][:default].blank?
      begin
        ActiveRecord::Base.transaction do
          @question = Question.find(params[:question][:id])
          if ((@question.question_type=='multiple choice' or @question.question_type=='yes/no with option') and params[:question][:option])
            options=Option.find(:all,:conditions =>{:question_id => params[:question][:id]})
            options.each do |option|
              option.destroy
            end
            options = []
            params[:question][:option].each do |option|
              options << Option.create(:option => option,:default_check =>params[:question][:default].include?(option)? true:false,:question_id =>@question.id)
            end
            @question.role_ids=params[:question][:role]
            if @question.question_type=='yes/no with option'
              yes_option = Option.create(:option => "option_yes", :question_id => @question.id)
              no_option = Option.create(:option => "option_no", :question_id => @question.id)
              @question.options << yes_option
              @question.options << no_option
              options.each do |option|
                option.update_attribute("parent_id", yes_option.id)
              end
            end
            @question.options << options
            @question.update_attributes(:questions => params[:question][:questions], :answer_text => params[:question][:answer_text])
          else
            @question.role_ids=params[:question][:role]
            @question.update_attributes(:questions => params[:question][:questions], :answer_text => params[:question][:answer_text])
          end
          flag=true
        end
      rescue Exception => exc
        flag=false
      end
    else
      puts "11111111111111111111111111111"
      status=true
      flash[:notice]="One default needs to be checked."
    end
    if flag==true && status==false
      @questions = Question.find(:all, :conditions => "status=1")
      redirect_to questions_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
