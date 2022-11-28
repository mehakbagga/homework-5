class ApplicationController < ActionController::Base
  private # helper_method under private is still availalbe in views?

  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def authenticate_user!
      if !current_user
          flash[:alert]= "Please Sign In"
          redirect_to new_session_path
      end
  end

end