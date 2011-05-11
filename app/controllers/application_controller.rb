class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
    def coach_id
    c=session[:coach_id]
     c
#     coach = Coach.find_by_email(session[:coach_id])
    
     
    end
end
