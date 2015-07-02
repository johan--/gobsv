class Ta::TwitterBot
  def self.client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = SocialKeys[Rails.env][:twitter_key]
      config.consumer_secret     = SocialKeys[Rails.env][:twitter_secret]
      config.access_token        = SocialKeys[Rails.env][:twitter_oauth_token]
      config.access_token_secret = SocialKeys[Rails.env][:twitter_oauth_token_secret]
    end
  end
end
