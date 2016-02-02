class Forums::Posture < ActiveRecord::Base
  belongs_to :actor
  belongs_to :organization
  belongs_to :entry
end
