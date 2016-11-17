require 'tracker'
module Tracker
  class Tracker::Article < ActiveRecord::Base

    belongs_to :author,   class_name: '::Tracker::Author'
    belongs_to :status,   class_name: '::Tracker::Status'

  end
end
