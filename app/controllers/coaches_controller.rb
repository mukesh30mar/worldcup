class CoachesController < ApplicationController
  def index
      @allteams =  Coach.all(:select => "team_name,activated_at")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coaches }
    end
  end

  def show
    @coach = Coach.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coach }
    end
  end

  def new
    @coach = Coach.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coach }
    end
  end

  def edit
    @coach = Coach.find(params[:id])
  end

  def create
    
    @coach = Coach.new(params[:coach])
    @coach.validate_password = true
    @coach.activation_code = rand(99999).to_s
    respond_to do |format|
      if  @coach.save
        Accountactivation.sendlink(@coach,request.host_with_port).deliver
        format.html { redirect_to(@login_path, :alert => 'Coach was successfully created. and check your mail for activate your account') }
        format.xml  { render :xml => @coach, :status => :created, :location => @coach }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coach.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @coach = Coach.find(params[:id])
    respond_to do |format|
      if @coach.update_attributes(params[:coach])
        format.html { redirect_to(@coach, :notice => 'Coach was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @coach.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy

    respond_to do |format|
      format.html { redirect_to(coaches_url) }
      format.xml  { head :ok }
    end
  end

  def activate
    @coach = Coach.find_by_activation_code(params[:activation_code])
    if  @coach.update_attributes(:activated_at => Time.now, :activation_code => nil)
      render(:text => "Your account is updates sucessfully")
    else
      render(:text => "fail in update")
    end
  end
end
