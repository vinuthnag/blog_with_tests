class ApplicationController < ActionController::Base
    # protect_from_forgery
    before_action :validate_current_user


    def validate_current_user
    	unless current_user.present?
    	redirect_to users_path
    	end 
    end

    private

	def current_user
    	@current_user ||= User.find(session[:user_id]) if session[:user_id]    
  	end 
end
