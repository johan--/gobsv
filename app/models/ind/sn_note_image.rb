class Ind::SnNoteImage < ActiveRecord::Base
  belongs_to :sn_note, class_name: '::Ind::SnNote'
  
  has_attached_file :file, styles: {
    small:  '300x300>',
  }, default_url: 'ta/missing.jpg'


  validates_attachment_content_type :file, content_type: %r{\Aimage\/.*\Z}

end
