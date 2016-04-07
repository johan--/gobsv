class ManagementsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    exp = record.expedient
    if exp.managements.count == 0
      record.errors[attribute] << (options[:message] || "No tiene gestiones, por favor agregue al menos una")
    end
    if exp.managements.pluck(:status).include?('process')
      record.errors[attribute] << (options[:message] || "Para poder cerrar el caso, por favor cierre todas sus gestiones")
    end
  end
end

class Complaints::ExpedientEvent < ActiveRecord::Base
  belongs_to :expedient, class_name: '::Complaints::Expedient'

  validates :status, presence: true
  validates :justification, managements: true, if: Proc.new{ |obj| obj.status == 'closed' }

  before_create :update_status_expedient

  private
    def update_status_expedient
      expedient.update_column(:status, self.status)
    end
end
