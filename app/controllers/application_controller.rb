class ApplicationController < ActionController::Base
  protect_from_forgery 
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  #facebook helpers
  def fb_city
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    graph = Koala::Facebook::API.new(@current_user.oauth_token)
    graph.get_connections("me", "likes")
    city_id = graph.get_object("me")["location"]["name"]
  end
  
  #yelp helpers
  def yelp_search
    parameters = { term: params[:term], limit: 16 }
    Yelp.client.search(fb_city, parameters).as_json
  end
  
  helper_method :current_user, :fb_city, :yelp_search
end
