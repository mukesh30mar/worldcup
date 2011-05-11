class CoachesController < ApplicationController
  # GET /coaches
  # GET /coaches.xml
  def index
    @coaches = Coach.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coaches }
    end
  end

  # GET /coaches/1
  # GET /coaches/1.xml
  def show
    @coach = Coach.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @coach }
    end
  end

  # GET /coaches/new
  # GET /coaches/new.xml
  def new
    @coach = Coach.new
   
   
    # @random = rand(99999).to_s
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @coach }
    end
  end

  # GET /coaches/1/edit
  def edit
    @coach = Coach.find(params[:id])
  end

  # POST /coaches
  # POST /coaches.xml
  def create

    p @link
    p params
    
    @coach = Coach.new(params[:coach])
    @coach.activation_code = rand(99999).to_s
    #@link = url_for(@coach)
#    p @coach.inspect
    # p @coach.activation_code
    respond_to do |format|
      if  @coach.save
        Accountactivation.sendlink(@coach,request.host_with_port).deliver
        format.html { redirect_to(@coach, :notice => 'Coach was successfully created. and check your mail for activate your account') }
        format.xml  { render :xml => @coach, :status => :created, :location => @coach }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coach.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /coaches/1
  # PUT /coaches/1.xml
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

  # DELETE /coaches/1
  # DELETE /coaches/1.xml
  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy

    respond_to do |format|
      format.html { redirect_to(coaches_url) }
      format.xml  { head :ok }
    end
  end
  
   def activate
  # activationcode=params[:activation_code]
   # p activationcode
    @coach = Coach.find_by_activation_code(params[:activation_code])
    #p @coach.class
    #@coach.activated_at = Time.now 
    #@coach.activation_code =Time.new

   if  @coach.update_attributes(:activated_at => Time.now, :activation_code => nil)
      render(:text => "Your account is updates sucessfully")

   else
      render(:text => "fail in update")
          end
     
    #p @coach
#    @coach = Coach.all(:conditions => {:activation_code => activationcode }).first.update_attributes(:activated_at => Time.now)  
    #p @coach.attributes
      # @coach.activated_at = Time.now
      # @coach.activation_code = nil
       
   end
end
