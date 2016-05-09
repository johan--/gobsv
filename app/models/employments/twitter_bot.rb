require 'employments'
module Employments
  class TwitterBot
    def self.client
      sckeys = SocialKeys[Rails.env]
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = sckeys[:twitter_key_employment]
        config.consumer_secret = sckeys[:twitter_secret_employment]
        config.access_token = sckeys[:twitter_oauth_token_employment]
        config.access_token_secret = sckeys[:twitter_oauth_token_secret_employment]
      end
    end
  end
end
