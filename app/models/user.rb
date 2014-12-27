class User < ActiveRecord::Base
  
  def self.from_omniauth(auth)
      puts "HERE IS SOME AUTH #{auth}"
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        puts "auth token!!!! " + user.oauth_token
        facebook = Koala::Facebook::API.new(user.oauth_token)
        fb_callback = facebook.get_object("me?fields=name,picture")
        puts "callback #{fb_callback}"
        user.profile_image_url = fb_callback['picture']['data']['url']
        user.save!
      end
   end
   
end
