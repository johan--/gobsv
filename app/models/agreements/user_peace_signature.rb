class Agreements::UserPeaceSignature < ActiveRecord::Base
  validates :email, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :name, :presence => true

end
