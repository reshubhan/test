class AnswersController < ApplicationController
  before_filter :login_required

  layout :answer_layout

  def answer_layout
    if current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end
  # GET /answers
  # GET /answers.xml
  def index
    @answers = Answer.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end
  
  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
    @answer = Answer.find(params[:id])
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])

    respond_to do |format|
      if @answer.save
        flash[:notice] = 'Answer was successfully created.'
        format.html { redirect_to(@answer) }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def user_answers
    answer_blank=false
    unless params[:options].blank?
      params[:question_ids].each do |x|
        unless !params[:options][x] || params[:options][x][0].blank?
          answer=Answer.find(:all,:conditions=>{:question_id=>x.to_i,:user_id=>current_user.id})
          if answer.blank?
            answer=Answer.new(:question_id=>x,:user_id=>current_user.id)
            params[:options].each do |z|
              if x==z[0]
                answer.option_id = z[1].join(',')
              end
            end
            answer.save
          else
            answer.each do |y|
              params[:options].each do |z|
                if x==z[0]
                  y.option_id=z[1].join(',')
                  y.save
                end
              end
            end
          end
        else
          answer_blank=true
        end
      end
      if answer_blank==true
        flash[:notice] = 'Options can not be empty.'
        redirect_to :controller=>"questions",:action=>"list_question"
      else
        @answers = Answer.find(:all, :joins => 'inner join questions q on q.id = answers.question_id', :conditions => "q.status=true and user_id=#{current_user.id}", :order => "q.rank asc")
      end
    else
      flash[:notice] = 'Please select at least one question.'
      redirect_to :controller=>"questions",:action=>"list_question"
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update
    @answer = Answer.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = 'Answer was successfully updated.'
        format.html { redirect_to(@answer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(answers_url) }
      format.xml  { head :ok }
    end
  end
end
