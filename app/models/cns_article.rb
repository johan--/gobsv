class CnsArticle < ActiveRecord::Base

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :article_date, presence: true
  validates :article_date, date: true
end
