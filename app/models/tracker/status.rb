require 'tracker'
module Tracker
  class Tracker::Status < ActiveRecord::Base

    belongs_to :status, class_name: '::Tracker::Status'
    has_many :statuses, class_name: '::Tracker::Status'

    def parent
      unless status.nil?
        status.name
      end
    end

  end
end
