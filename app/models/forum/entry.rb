require 'forum'
class Forum::Entry < ActiveRecord::Base
  acts_as_taggable
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_attached_file :asset
  do_not_validate_attachment_file_type :asset

  before_save :set_asset, if: Proc.new { |obj| obj.kind == 'article' }
  before_save :set_description, if: Proc.new { |obj| obj.kind == 'article' }

  belongs_to :actor, class_name: '::Forum::Actor'
  belongs_to :organization, class_name: '::Forum::Organization'
  belongs_to :theme, class_name: '::Forum::Theme'

  validates :organization_id, :theme_id, :kind, :entry_at, presence: true

  default_scope { order(entry_at: :desc, created_at: :desc) }
  scope :pensions, ->(kind) { where("theme_id = 1 AND kind = ?", kind) }

  KIND = {
    'article' => 'Articulo',
    'document' => 'Documento',
    'video' => 'Video',
    #'image' => 'Imagen',
    'twitter' => 'Twitter',
    'facebook' => 'Facebook'
  }

  def set_asset
    if url.present? && asset.blank?
      page = MetaInspector.new(url)
      self.asset = URI.parse(page.images.best)
    end
    rescue
      nil
  end

  def set_description
    if description.blank?
      page = MetaInspector.new(url)
      self.description = page.description
    end
    rescue
      nil
  end

  def youtubeid
    {
      1 => %r{youtu\.be\/([^\?]*)},
      5 => %r{^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*}
    }.each do |position, regex|
      matches = url.match(regex)
      return matches[position] unless matches.nil?
    end
    nil
  end
  
  def self.random_entry_id(kind)
    id = pensions(kind).ids.sort_by{rand}.first
  end
  
  def self.twt_article
    r = "#ElSalvador Descargá la propuesta de reforma de pensiones, mirá lo que otros opinan y participá vos también http://www.reformadepensiones.com #GobSV"
    entry   = find(self.random_entry_id("article"))
    
    if entry.title.blank?
      self.twt_article
    else
      hashtag     = "#PensionesSV "
      entry_title = entry.title.truncate(100)
      r           = hashtag + entry_title + " " + entry.url 
    end
    r
  end
  
  def self.retweet_id
    entry   = find(self.random_entry_id("twitter"))
    
    if entry.url.blank?
      self.retweet_id
    else
      r = entry.url.split("/")[-1]
    end
    r
  end

  def self.twt_document
    r = "#ElSalvador Descargá la propuesta de reforma de pensiones, mirá lo que otros opinan y participá vos también http://www.reformadepensiones.com #GobSV"
    entry   = find(self.random_entry_id("document"))
    
    if entry.asset.url.blank?
      self.twt_document
    else
      hashtag     = "#PensionesSV "
      entry_title = entry.title.truncate(100)
      entry_doc   = " http://reformadepensiones.com"+ entry.asset.url 
      r           = hashtag + entry_title + entry_doc
    end
    r
  end

  def self.twt_video
    r = "#ElSalvador Descargá la propuesta de reforma de pensiones, mirá lo que otros opinan y participá vos también http://www.reformadepensiones.com #GobSV"
    entry   = find(self.random_entry_id("video"))
    
    if entry.url.blank?
      self.twt_video
    else
      hashtag     = "#PensionesSV "
      entry_title = entry.title.truncate(100)
      entry_video = entry.url 
      r           = hashtag + entry_title + " " + entry_video
    end
    r
  end

  def self.twt_facebook
    r = "#ElSalvador Descargá la propuesta de reforma de pensiones, mirá lo que otros opinan y participá vos también http://www.reformadepensiones.com #GobSV"
    entry   = find(self.random_entry_id("facebook"))
    
    if entry.url.blank?
      self.twt_video
    else
      hashtag        = "#PensionesSV "
      entry_title    = entry.title.truncate(100)
      entry_facebook = entry.url 
      r              = hashtag + entry_title + " " + entry_facebook
    end
    r
  end

end
