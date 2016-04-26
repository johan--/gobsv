require 'employments'
class Employments::PlazaLanguage < ActiveRecord::Base
  scope :indispensable, -> {where(req_code: 2)}
end
