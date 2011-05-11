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
        redirect_to players_path
      end  
    else
      redirect_to login_path, :alert => "Invalid user id or password"
    end
  end

  def destroy
    session[:coach_id] = nil
    redirect_to coaches_path, :alert => "Logged out"
  end

end
