require 'ta'
module Ta
  class Comment < ActiveRecord::Base
    belongs_to :article, class_name: '::Ta::Article'
    belongs_to :comment, class_name: '::Ta::Comment'

    validates :name, presence: true

    validates :email,
              presence: true,
              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

    validates :message, presence: true

    enum status: [:revision, :publish]

    scope :publish, -> { where(status: statuses[:publish]) }

    def avatar_letter
      if ('a'..'z').to_a.any? { |letter| name.downcase.start_with?(letter) }
        name[0].upcase
      else
        '@'
      end
    end
  end
end
