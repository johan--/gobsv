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

  KIND = {
    'article' => 'Articulo',
    'document' => 'Documento',
    'video' => 'Video',
    'image' => 'Imagen',
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
end
