class Inv::Product < ActiveRecord::Base

  has_many :product_movements, class_name: '::Inv::ProductMovement'
  belongs_to :unit,            class_name: '::Inv::Unit'

  validates :name,    presence: true, uniqueness: { case_sensitive: false }
  validates :unit_id, presence: true

  before_save :uppercase

  def uppercase
    name.upcase!
  end

  def stock(warehouse)
    product_movements.where(warehouse_id: warehouse.id, kind: ::Inv::ProductMovement.kinds[:in]).map(&:quantity).sum -
    product_movements.where(warehouse_id: warehouse.id, kind: ::Inv::ProductMovement.kinds[:out]).map(&:quantity).sum
  end

  ##
  # Encode product methods

  before_create :encode

  def encode
    self.code = [code_seed, parsed_next_correlative].join('-')
  end

  def self.code_correlative_length
    4
  end

  def code_seed
    I18n.transliterate(name[0...2]).upcase
  end

  def current_correlative_from_code
    self.class.where("code like '#{code_seed}%'").last.code.split('-').last.to_i
  rescue
    0
  end

  def parsed_next_correlative
    next_correlative.to_s.rjust(self.class.code_correlative_length, 0.to_s)
  end

  def next_correlative
    current_correlative_from_code + 1
  end

end
