class Ta::CategoriesController < TaController

  def index
    @article  = Ta::Article.publish.front.newer.first
    @article  = Ta::Article.publish.newer.first if @article.nil?

    @articles = Ta::Article.publish.newer.where.not(id: @article.id).limit(3)

    @gallery    = Ta::Article.publish.gallery.newer.first
    @galleries  = Ta::Article.publish.gallery.newer.limit(2).offset(1)

    @yesterday_articles = Ta::Article.yesterday.publish.newer.limit(3)

    @featured = Ta::Article.featured.newer.limit(5)

    @channel = Yt::Channel.new id: SocialKeys[Rails.env][:youtube_channel_id]

    begin
      client = Soundcloud.new({
        client_id:     SocialKeys[Rails.env][:soundcloud_key],
        client_secret: SocialKeys[Rails.env][:soundcloud_secret],
        username:      SocialKeys[Rails.env][:soundcloud_username],
        password:      SocialKeys[Rails.env][:soundcloud_password]
      })
      @tracks = client.get('/me/tracks', limit: 4, order: 'hotness').select{ |track| track.downloadable? }
    rescue
      @tracks = []
    end

    begin
      @tweets = Ta::TwitterBot.client.user_timeline("TransparenciaSV").take(3)
    rescue
      @tweets = []
    end

    set_meta_tags ({
      title: 'Noticias sobre transparencia, acceso a la Información y anticorrupción en El Salvador',
      site: 'TRANSPARENCIA ACTIVA',
      description: 'Transparencia Activa es un periódico digital que divulga las acciones de transparencia desarrolladas, rendición de cuentas, acceso a la información y lucha',
      keywords: 'noticias el salvador, trasparencia el salvador, transparencia activa, gobierno de el salvador, informacion el salvador, presidente funes,  informacion publica el salvador, noticias de verdad, gobierno del cambio',
      canonical: ta_root_url,
      author: 'Transparencia Activa',
      og: {
        title: 'Noticias sobre transparencia, acceso a la Información y anticorrupción en El Salvador',
        image: URI.join(request.url, view_context.image_path('ta/missing.jpg')),
        description: 'Transparencia Activa es un periódico digital que divulga las acciones de transparencia desarrolladas, rendición de cuentas, acceso a la información y lucha',
        url: ta_root_url
      }
    })
  end

  def show
    @category = Ta::Category.find params[:id]
    @articles = @category.articles.publish.newer.paginate(page: params[:page])

    add_breadcrumb 'Inicio', ta_root_url
    add_breadcrumb @category.name, nil

    set_meta_tags ({
      title: @category.name,
      site: 'Transparencia Activa',
      reverse: true,
      description: 'Transparencia Activa es un periódico digital que divulga las acciones de transparencia desarrolladas, rendición de cuentas, acceso a la información y lucha',
      keywords: 'noticias el salvador, trasparencia el salvador, transparencia activa, gobierno de el salvador, informacion el salvador, presidente funes,  informacion publica el salvador, noticias de verdad, gobierno del cambio',
      canonical: ta_category_url(@category),
      author: 'Transparencia Activa',
      og: {
        title: @category.name,
        image: URI.join(request.url, view_context.image_path('ta/missing.jpg')),
        description: 'Transparencia Activa es un periódico digital que divulga las acciones de transparencia desarrolladas, rendición de cuentas, acceso a la información y lucha',
        url: ta_category_url(@category)
      }
    })
  end
end
