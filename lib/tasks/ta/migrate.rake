=begin
class TaWp < ActiveRecord::Base
  # Return the list of columns registered for the model. Used internally by
  # ActiveRecord
  def self.columns
    @columns ||= []
  end

  # Register a new column.
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  # Register a set of colums with the same SQL type
  def self.add_columns(sql_type, *args)
    args.each do |col|
      column col, sql_type
    end
  end

  establish_connection(
    adapter:  'mysql2',
    database: 'transparenciaactiva',
    username: 'root',
    password: ''
  )
end

class TaWp::PostImageGallery < TaWp
  self.table_name  = 'tasitiowp_posts'

  add_columns :integer, :post_parent
  add_columns :string, :guid

  PostFormatGalleryId = 1691

  default_scope {
    where(post_type: 'attachment', post_status: 'inherit')
      .where("post_parent IN (
        SELECT
        	t3.object_id
        FROM tasitiowp_terms t1
        LEFT JOIN tasitiowp_term_taxonomy t2 ON (t2.term_id = t1.term_id)
        LEFT JOIN tasitiowp_term_relationships t3 ON (t3.term_taxonomy_id = t2.term_taxonomy_id)
        LEFT JOIN posts_categories t4 ON (t4.wp_post_id = t3.object_id)
        WHERE
        	t1.term_id = #{PostFormatGalleryId}
      )")
      .where("post_mime_type LIKE 'image%'")
  }

  def self.migrate
    counter = 0
    all.each do |wp_image|
      article_id = TaWp::PostsCategory.where(wp_post_id: wp_image.post_parent).first.try(:post_id)
      article = Ta::Article.find article_id
      unless article.images.any?{ |image| wp_image.guid.end_with?(image.image_file_name) }
        begin
          article.images << Ta::Image.new(image: URI.parse(URI.encode(wp_image.guid)))
          article.save(validate: false)
          puts "#{counter} artículos con imágenes migradas"
          counter += 1
        rescue
          puts "Problemas con imagen:\t#{wp_image.guid}"
        end
      end
    end
  end
end

class TaWp::PostImage < TaWp
  self.table_name  = 'tasitiowp_posts'

  add_columns :integer, :post_parent
  add_columns :string, :guid

  default_scope {
    where(post_type: 'attachment', post_status: 'inherit')
      .where("post_parent IN (SELECT wp_post_id FROM #{TaWp::PostsCategory.table_name})")
      .where("post_mime_type LIKE 'image%'")
  }

  def self.migrate
    all.each do |wp_image|
      article_id = TaWp::PostsCategory.where(wp_post_id: wp_image.post_parent).first.try(:post_id)
      article = Ta::Article.find article_id
      unless article.image.present?
        begin
          article.image = URI.parse(URI.encode(wp_image.guid))
          article.save
        rescue
          puts "Problemas con imagen:\t#{wp_image.guid}"
        end
      end
    end
  end
end

class TaWp::Category < TaWp
  self.primary_key = 'term_id'
  self.table_name  = 'tasitiowp_terms'

  default_scope {
    where("term_id IN (SELECT wp_category_id FROM #{TaWp::PostsCategory.table_name})")
      .order('name')
      .uniq
  }

  add_columns :integer, :term_id
  add_columns :string,  :name, :slug

  def self.migrate
    all.each do |wp_category|
      category = Ta::Category.create(name: wp_category.name, slug: wp_category.slug)
      TaWp::PostsCategory.where(wp_category_id: wp_category.id).update_all(category_id: category.id)
    end
  end
end

class TaWp::Article < TaWp
  include ActionView::Helpers::TextHelper

  self.table_name = 'tasitiowp_posts'

  default_scope { where(post_type: 'post', post_status: 'publish') }

  add_columns :integer,   :ID, :post_author
  add_columns :string,    :post_title, :post_status, :post_name
  add_columns :text,      :post_excerpt, :post_content
  add_columns :datetime,  :post_date, :post_modified

  def self.migrate
    all.each do |wp_post|

      category_id = TaWp::PostsCategory.where(wp_post_id: wp_post.ID).first.try(:category_id)
      wp_post.clear_content!
      article = Ta::Article.create(
        title: wp_post.post_title,
        summary: wp_post.post_excerpt,
        content: wp_post.post_content,
        created_at: wp_post.post_date,
        updated_at: wp_post.post_modified,
        status: wp_post.post_status,
        author_id: wp_post.post_author,
        slug: wp_post.post_name,
        category_id: category_id,
        published_at: wp_post.post_date
      )

      TaWp::PostsCategory.where(wp_post_id: wp_post.ID).first.update_column(:post_id, article.id)
    end
  end

  def clear_content!
    self.post_content.gsub!(/\[\/?(?:caption|wide|pullquote|b|u|i|s|size|color|center|quote|url|img|ul|ol|list|li|\*|code|table|tr|th|td|youtube|gvideo)(?:=[^\]\s]+)?\]/, '')
    self.post_content.gsub!('<!--more-->', '')
    self.post_content = Sanitize.fragment(
      self.post_content,
      elements: ['img', 'a', 'b', 'strong', 'i', 'u', 'blockquote', 'small', 'em'],
      attributes: { 'img' => ['src'], 'a' => ['href', 'target'] }
    )
    self.post_content = simple_format(self.post_content)

    ##
    # Whitespace between \s and $ is not a normal whitespace
    # DO NOT remove it!
    self.post_content.gsub!(/<p>[\s $]*<\/p>/, '')
  end
end

class TaWp::Tag < TaWp

  self.table_name = 'posts_tags'

  add_columns :integer, :wp_post_id
  add_columns :string, :tag

  ##
  # execute just if posts_categories tables is already loaded
  def self.migrate
    pluck(:wp_post_id).uniq.each do |wp_post_id|
      article_id = TaWp::PostsCategory.where(wp_post_id: wp_post_id).first.try(:post_id)
      article = Ta::Article.find article_id
      article.tag_list = self.where(wp_post_id: wp_post_id).map(&:tag).join(',')
      article.save
    end
  end
end

class TaWp::PostsTag < TaWp
  self.table_name = 'posts_tags'

  add_columns :integer, :wp_post_id
  add_columns :string, :tag

  def self.prepare_table
    if connection.table_exists? self.table_name
      connection.execute("TRUNCATE TABLE #{self.table_name}")
    else
      connection.create_table self.table_name do |t|
        t.integer :wp_post_id
        t.string :tag
      end
    end
  end

  def self.populate_table
    connection.execute("INSERT INTO #{self.table_name}
      SELECT
      	null,
      	t4.id,
      	t1.name
      FROM tasitiowp_terms t1
      LEFT JOIN tasitiowp_term_taxonomy t2 ON (t2.term_id = t1.term_id)
      LEFT JOIN tasitiowp_term_relationships t3 ON (t3.term_taxonomy_id = t2.term_taxonomy_id)
      LEFT JOIN tasitiowp_posts t4 ON (t4.id = t3.object_id)
      WHERE
      	t4.post_status = 'publish'
      	AND t4.post_type = 'post'
      	AND t2.taxonomy = 'post_tag'
      ORDER BY
      	t4.post_date ASC")
  end

  def self.drop_table
    connection.execute("DROP TABLE #{self.table_name}") if connection.table_exists?(self.table_name)
  end
end

class TaWp::PostsCategory < TaWp
  self.table_name = 'posts_categories'

  add_columns :integer, :wp_category_id, :wp_post_id, :article_id, :category_id

  def self.prepare_table
    if connection.table_exists? self.table_name
      connection.execute("TRUNCATE TABLE #{self.table_name}")
    else
      connection.create_table self.table_name do |t|
        t.integer :wp_category_id
        t.integer :wp_post_id
        t.integer :category_id
        t.integer :post_id
      end
    end
  end

  def self.populate_table
    connection.execute("INSERT INTO #{self.table_name}
      SELECT
        t1.id,
      	t4.term_id,
      	t1.id,
        0,
        0
      FROM tasitiowp_posts t1
      LEFT JOIN tasitiowp_term_relationships t2 ON (t1.id = t2.object_id)
      LEFT JOIN tasitiowp_term_taxonomy t3 ON (t3.term_taxonomy_id = t2.term_taxonomy_id)
      LEFT JOIN tasitiowp_terms t4 ON (t3.term_id = t4.term_id)
      WHERE
      	t1.post_status = 'publish'
      	AND t1.post_type = 'post'
        AND t3.taxonomy = 'category'
      GROUP BY
      	t1.id
      ORDER BY
      	t1.post_date ASC")
  end

  def self.drop_table
    connection.execute("DROP TABLE #{self.table_name}") if connection.table_exists? self.table_name
  end
end

namespace :ta do
  desc 'Migrate TA information from wordpress TA site'
  task migrate: :environment do |_tsk, _args|
    # TaWp::PostsCategory.drop_table
    #TaWp::PostsCategory.prepare_table
    #TaWp::PostsCategory.populate_table
    #TaWp::Category.migrate
    #TaWp::Article.migrate
    #TaWp::PostImage.migrate
    #TaWp::PostsTag.prepare_table
    #TaWp::PostsTag.populate_table
    #TaWp::Tag.migrate
    # TaWp::PostsTag.drop_table
    TaWp::PostImageGallery.migrate
  end
end
=end
