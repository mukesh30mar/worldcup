class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def coach_id
    c=session[:coach_id]
    c
  end

  protected

  def authorize
    unless Coach.find_by_id(coach_id)
      redirect_to login_path, :alert => "please log in"
    end
  end
end
