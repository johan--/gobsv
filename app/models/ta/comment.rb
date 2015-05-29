class Ta::Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :comment
end
