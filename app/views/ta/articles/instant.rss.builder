#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Noticias de Transparencia Activa"
    xml.author "Secretaria de Participacion, Transparencia y Anticorrupcion"
    xml.link ta_articles_url


    for article in @articles
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author article.author.try(:name)
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link ta_article_url(article)
        xml.guid article.id
        text = article.summary
		# if you like, do something with your content text here e.g. insert image tags.
		# Optional. I'm doing this on my website.
        if article.image.exists?
          image_url = article.image.url(:medium)
          image_tag = "<p><img src='" + image_url +  "' alt='" + article.title + "' title='" + article.title + "'/></p>"
          text = text.sub('{image}', image_tag)
        end
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end
