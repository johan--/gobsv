# encoding: UTF-8

xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', xmlns: 'http://purl.org/rss/2.0/' do
  xml.channel do
    xml.title 'Noticias de Transparencia Activa'
    xml.author 'Secretaria de Participacion, Transparencia y Anticorrupcion'
    xml.link ta_articles_url

    @articles.each do |article|
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ''
        end
        xml.author article.author.try(:name)
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link ta_article_url(article)
        xml.guid article.id
        xml.description article.summary
        xml.tag! 'content:encoded' do
          xml.cdata! parsed_content(article)
        end
      end
    end
  end
end
