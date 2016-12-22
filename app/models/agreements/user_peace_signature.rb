class Agreements::UserPeaceSignature < ActiveRecord::Base
  validates :email, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, :allow_nil => true, :if => :email?


  validates :name, :presence => true

end
