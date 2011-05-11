class SessionController < ApplicationController
  def new
    
  end

  def create
    if coach = Coach.authenticate(params[:email], params[:encrypted_password])
      @status = Coach.find_by_email(params[:email])
      if @status.activated_at.blank?
        redirect_to login_path, :alert => "Your Status is not active"
      else
        session[:coach_id] = coach.id
        #p "coach id="+ session[:coach_id].to_s
        redirect_to players_path
        #render (:text => "Login Sucessfull")
      end  
    else
      redirect_to login_path, :alert => "Invalid user id or password"
      #redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  def destroy
    
  end

end
