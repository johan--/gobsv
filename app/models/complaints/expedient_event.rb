class ManagementsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if record.status != 'process'
    expedient = record.expedient
    if expedient.managements.count == 0
      record.errors[attribute] << (options[:message] || "No tiene gestiones, por favor agregue al menos una")
    end
  end
end

class Complaints::ExpedientEvent < ActiveRecord::Base
  belongs_to :expedient, class_name: '::Complaints::Expedient'

  validates :status, presence: true
  validates :justification, presence: true

  before_create :update_status_expedient

  private
    def update_status_expedient
      expedient.update_column(:status, self.status)
    end
end
