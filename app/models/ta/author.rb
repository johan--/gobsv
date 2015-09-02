module Ta
  class Author < ActiveRecord::Base
    belongs_to :admin
  end
end
