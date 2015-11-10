class Req::Requirement < ActiveRecord::Base

  belongs_to :admin, class_name: 'Admin'

  has_many :product_requirements, class_name: '::Req::ProductRequirement'
  accepts_nested_attributes_for :product_requirements, allow_destroy: true

  validates :product_requirements, presence: true

  enum status: [:pending, :declined, :delivered]

  ##
  # Encode product methods

  before_create :encode

  def encode
    self.code = [self.class.code_seed, self.class.parsed_next_correlative].join('-')
  end

  def self.correlative_length
    4
  end

  def self.code_seed
    Date.today.year
  end

  def self.parsed_next_correlative
    self.next_correlative.to_s.rjust(self.correlative_length, 0.to_s)
  end

  def self.current_correlative
    self.last.nil? || self.last.code.nil? || self.last.created_at.year != Date.today.year ? 0 : current_correlative_from_code
  end

  def self.current_correlative_from_code
    self.last.code.split('-').last.to_i
  end

  def self.next_correlative
    current_correlative + 1
  end
end
