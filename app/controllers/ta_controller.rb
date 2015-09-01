class TaController < ApplicationController

  before_action :categories
  before_action :pages
  before_action :init_q

  def init_q
    @q = Ta::Article.ransack(params[:q])
  end

  def categories
    @categories = Ta::Category.order(:name)
  end

  def pages
    @pages = Ta::Page.order(:priority)
  end

  ##
  helper_method :newer_tweets
  #
  def newer_tweets
    @newer_tweets ||= Ta::TwitterBot
                      .client
                      .user_timeline('TransparenciaSV')
                      .take(3)
  rescue
    []
  end

  ##
  helper_method :newest_tweet
  #
  def newest_tweet
    newer_tweets.try(:first)
  end

  ##
  helper_method :featured_articles
  #
  def featured_articles
    @featured_articles ||= Ta::Article.featured.newer.limit(5)
  end

  ##
  helper_method :yesterday_articles
  #
  def yesterday_articles
    @yesterday_articles ||= Ta::Article.yesterday.publish.newer.limit(3)
  end

  ##
  helper_method :audio_articles
  #
  def audio_articles
    @audio_articles ||= Ta::Article.publish.newer.audio_layout.limit(3)
  end

  ##
  helper_method :video_articles
  #
  def video_articles
    @video_articles ||= Ta::Article.publish.newer.video_layout.limit(3)
  end

  ##
  helper_method :gallery_articles
  #
  def gallery_articles
    @gallery_articles ||= Ta::Article.publish.gallery_layout.newer.limit(3)
  end
end
