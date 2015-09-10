require 'ta'
module Ta
  class TwitterBot
    def self.client
      sckeys = SocialKeys[Rails.env]
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = sckeys[:twitter_key]
        config.consumer_secret     = sckeys[:twitter_secret]
        config.access_token        = sckeys[:twitter_oauth_token]
        config.access_token_secret = sckeys[:twitter_oauth_token_secret]
      end
    end
  end
end
