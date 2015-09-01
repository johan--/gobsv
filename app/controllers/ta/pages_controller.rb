module Ta
  class PagesController < TaController
    def show
      @page     = Ta::Page.find params[:id]
      @lastest  = Ta::Article.publish.newer.limit(2)

      begin
        client = Soundcloud.new(
          client_id:     SocialKeys[Rails.env][:soundcloud_key],
          client_secret: SocialKeys[Rails.env][:soundcloud_secret],
          username:      SocialKeys[Rails.env][:soundcloud_username],
          password:      SocialKeys[Rails.env][:soundcloud_password]
        )
        @track = client.get('/me/tracks', limit: 1, order: 'hotness').first
      rescue
        @track = nil
      end

      begin
        @tweet = Ta::TwitterBot.client.user_timeline('TransparenciaSV').first
      rescue
        @tweet = nil
      end

      set_meta_tags(
        title: @page.name,
        site: 'Transparencia Activa',
        description: @page.content.truncate(150, separator: ' '),
        canonical: ta_page_url(@page),
        reverse: true,
        og: {
          title: @page.name,
          description: @page.content.truncate(150, separator: ' '),
          url: ta_page_url(@page)
        }
      )

      add_breadcrumb 'Inicio', ta_root_url
      add_breadcrumb @page.name, nil
    end
  end
end
