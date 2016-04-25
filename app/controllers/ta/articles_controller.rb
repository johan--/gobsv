module Ta
  class ArticlesController < TaController
    protect_from_forgery :except => :feed

    ##
    # GET ta/articles
    def index
      @q        = Ta::Article.ransack(params[:q])
      @articles = @q.result.publish.newer.paginate(page: params[:page])

      add_breadcrumb 'Inicio', ta_root_url
      add_breadcrumb 'Todas las noticias', nil
    end

    ##
    # GET ta/galleries
    def galleries
      @articles = Ta::Article
                  .gallery
                  .publish
                  .newer
                  .paginate(page: params[:page])

      add_breadcrumb 'Inicio', ta_root_url
      add_breadcrumb 'Galerías', nil
    end

    ##
    # GET ta/articles/:id
    def show
      @article  = Ta::Article.find params[:id]
      @comment  = Ta::Comment.new
      @comments = @article
                  .comments
                  .where(status: Ta::Comment.statuses[:publish])
                  .order(:created_at)

      @lastest  = Ta::Article.publish.newer.where.not(id: @article.id).limit(2)
      @related  = @article.find_related_tags.limit(2)

      @audio    = Ta::Article.publish.audio_layout.newer.first

      @jobs = Employments::Plaza.active.available.order(created_date: :desc).limit(3)

      if @article.audio?
        client = Soundcloud.new(
          client_id:     SocialKeys[Rails.env][:soundcloud_key],
          client_secret: SocialKeys[Rails.env][:soundcloud_secret],
          username:      SocialKeys[Rails.env][:soundcloud_username],
          password:      SocialKeys[Rails.env][:soundcloud_password]
        )
        @audioinf = client.get('/oembed', url: @article.audio_url)
      end

      begin
        @tweet = Ta::TwitterBot.client.user_timeline('TransparenciaSV').first
      rescue
        @tweet = nil
      end

      set_meta_tags(
        title: @article.title,
        site: 'Transparencia Activa',
        description: @article.summary,
        keywords: @article.tag_list,
        canonical: ta_article_url(@article),
        reverse: true,
        author: @article.author.try(:name),
        og: {
          title: @article.title,
          image: URI.join(request.url, @article.image.url(:medium)),
          description: @article.summary,
          url: ta_article_url(@article)
        }
      )

      add_breadcrumb 'Inicio', ta_root_url
      add_breadcrumb @article.category.name, ta_category_url(@article.category)
      add_breadcrumb @article.title, nil
    end

    def feed
      @articles = Ta::Article.publish.newer.limit(10)
      respond_to do |format|
        format.rss { render :layout => false }
      end
    end
  end
end
