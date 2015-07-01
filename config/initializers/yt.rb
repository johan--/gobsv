Yt.configure do |config|
  config.log_level = :debug

  config.api_key       = SocialKeys[Rails.env][:youtube_key]
  config.client_secret = SocialKeys[Rails.env][:youtube_secret]
  config.client_id     = SocialKeys[Rails.env][:youtube_client_id]
end
