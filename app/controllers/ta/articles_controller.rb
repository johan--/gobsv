module Ta
  class ArticlesController < TaController
    protect_from_forgery :except => :feed

    ##
    # GET ta/articles
    def index
      @keyword  = params[:q]
      @q        = Ta::Article.ransack(@keyword)
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

    def print
      @article = Ta::Article.find params[:id]
      set_meta_tags title: "Transparencia Activa,
        #{l(@article.published_at.to_date, format: :long)}"
      render layout: 'ta_print'
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
      @related  = @article.find_related_tags.limit(4)

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

    def instant
      @articles = Ta::Article
                  .publish
                  .newer
                  .limit(10)
                  # .where([
                  #          'published_at > :diff OR updated_at > :diff',
                  #          { diff: Time.zone.now - 10.minutes }
                  #        ])

      respond_to do |format|
        format.rss { render layout: false }
      end
    end

    helper_method :absolutes_url!
    #
    def absolutes_url!(article)
      html = template(article)
      doc = Nokogiri::HTML(html)
      replace_relatives_hrefs!(doc)
      replace_relatives_srcs!(doc)
      unwrap_frames_images!(doc)
      wrap_frames_images!(doc)
      frames_dimensions!(doc)
      clear_empty_paragraphs!(doc)
      doc.to_html
    end

    def sanitized_content(article)
      view_context.sanitize(
        absolutes_url!(article),
        tags: %w(h1 h2 h3 a b img p strong em i u figure quote
                 time header article iframe),
        attributes: %w(href target src class datetime width height)
      )
    end

    helper_method :parsed_content
    #
    def parsed_content(article)
      '<html lang="es"><head><meta charset="utf-8">' \
      "<title>#{article.title}</title>" \
      "<meta name=\"description\" content=\"#{article.summary}\" />" \
      "<link rel=\"canonical\" href=\"#{ta_article_url(article)}\" />" \
      "</head><body>#{sanitized_content(article)}</body></html>"
    end

    def template(article)
      "<article><header><figure><img src='#{article.image.url}'></figure>" \
        "<h1>#{article.title}</h1>" \
        '<h3 class=\"op-kicker\">' \
        "#{article.pretitle.blank? ? article.category.name : article.pretitle}" \
        '</h3>' \
        "<time class=\"op-published\" datetime=\"#{article.created_at}\">" +
        I18n.l(article.published_at.to_date, format: :long) +
        "</time></header>#{article.content}</article>"
    end

    def replace_relatives_srcs!(doc)
      doc.css('img').each do |img|
        unless absolute_url?(img.attributes['src'].value)
          absolute = replace_relatives_url(img.attributes['src'].value)
          img.attributes['src'].value = absolute
        end
      end
    end

    def replace_relatives_hrefs!(doc)
      doc.css('a').each do |link|
        unless absolute_url?(link.attributes['href'].value)
          absolute = replace_relatives_url(link.attributes['href'].value)
          link.attributes['href'].value = absolute
        end
      end
    end

    def absolute_url?(url)
      url.match(%r{https?:\/\/})
    end

    def unwrap_frames_images!(doc)
      doc.css('img, iframe').each do |e|
        e.parent.replace(e) while e.parent.name == 'p'
      end
    end

    def wrap_frames_images!(doc)
      doc.css('img, iframe').each do |e|
        e.swap("<figure>#{e}</figure>") unless e.parent.name == 'figure'
      end
    end

    def frames_dimensions!(doc)
      doc.css('iframe').each do |e|
        e.attributes['width'].value = 320.to_s
        e.attributes['height'].value = 180.to_s

        u = URI(URI.decode(e.attributes['src'].value))
        p = URI.decode_www_form(u.query || '')
        p.delete(p.select { |x| x.include?('width') }.first)
        p << %w(width 320) << %w(height 180)
        u.query = URI.encode_www_form(p)
        e.attributes['src'].value = u.to_s
      end
    end

    def clear_empty_paragraphs!(doc)
      doc.css('p').each { |p| p.remove if p.text.blank? }
    end

    def replace_relatives_url(path)
      separator = path.start_with?('/') ? '' : '/'
      'http://' + [request.host, path].join(separator)
    end
  end
end
