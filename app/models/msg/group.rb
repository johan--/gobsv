class Msg::Group < ActiveRecord::Base
  serialize :contacts, Array

  attr_accessor :skip_fill_contacts

  has_attached_file :asset
  validates :asset, attachment_presence: true
  do_not_validate_attachment_file_type :asset

  validates :name, presence: true

  validate :valid_file_name

  after_save :fill_contacts, unless: Proc.new{|o| o.skip_fill_contacts.to_i == 1}

  has_many :messages


  def valid_file_name
    errors.add(:asset, 'no es un archivo csv') if File.extname(asset_file_name.to_s).downcase != '.csv'
  end

  def full_name
    "#{self.name} (#{self.contacts.size} contactos)"
  end

  private
    def fill_contacts
      if asset_updated_at_changed?
        # Hay un nuevo csv, lo leemos e insertamos los valores en contactos
        require 'csv'
        arr = []
        CSV.foreach(asset.path, headers: true) do |row|
          begin
            arr << {name: row[0], phone: row[1].try(:gsub, /[^\d]/, '')}
          rescue
            puts "Error en la carga"
          end
        end
        self.skip_fill_contacts = 1
        self.contacts = arr
        self.save
      end
    end

end
