# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are
# already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( admin.css admin.js admin/login.css )
Rails.application.config.assets.precompile += %w( complaints.css complaints.js )
Rails.application.config.assets.precompile += %w( www.css www.js )
Rails.application.config.assets.precompile += %w( ta.css ta.js ta/*.js )
Rails.application.config.assets.precompile += %w( ta_print.css )
Rails.application.config.assets.precompile += %w( employments.css employments.js )
Rails.application.config.assets.precompile += %w( forums.css forums.js )
Rails.application.config.assets.precompile += %w( ver.css ver.js )
Rails.application.config.assets.precompile += %w( user/login.css user/login.js )
Rails.application.config.assets.precompile += %w( goverment_services.css goverment_services.js )
Rails.application.config.assets.precompile += %w( indicators.css indicators.js )
Rails.application.config.assets.precompile += %w( agreements.css agreements.js )

Rails.application.config.assets.precompile += %w( *.eot *.woff *.ttf *.svg )
Rails.application.config.assets.precompile += %w( *.png *.jpeg *.jpg *.gif )

Rails.application.config.assets.precompile += %w( ckeditor/* )
Rails.application.config.assets.paths << "#{Rails.root}/app/assets/videos"
Rails.application.config.assets.paths << "#{Rails.root}/app/assets/fonts"
