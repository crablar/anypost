class ApplicationController < ActionController::Base
  protect_from_forgery 
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def get_fb_info(param)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    facebook = Koala::Facebook::API.new(@current_user.oauth_token)
    facebook.get_object("me?fields=#{param}")
  end
  
  helper_method :current_user
  helper_method :user_stuff
end
