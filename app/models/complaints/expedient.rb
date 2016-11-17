require 'complaints'
module Complaints
  class Expedient < ActiveRecord::Base
    has_many :events, class_name: '::Complaints::ExpedientEvent', dependent: :destroy
    has_many :expedients
    belongs_to :expedient
    has_many :managements, class_name: '::Complaints::ExpedientManagement', dependent: :destroy
    belongs_to :institution

    scope :newer, -> { order(received_at: :desc) }
    scope :status, -> (status) { where(status: status=='closed' ? ['closed', 'redirected'] : status) }

    has_attached_file :asset
    do_not_validate_attachment_file_type :asset

    validates :kind, :comment, presence: true

    KIND = {
      'email' => 'Correo electrónico',
      'ga' => 'Gobierno Abierto',
      'own' => 'Medios Propios de las instituciones del OE y Autónomas',
      '135' => 'Número 135',
      'other' => 'Otros',
      'press' => 'Prensa',
      'social' => 'Redes sociales'
    }

    def set_correlative
      self.correlative = "TEST-2015-#{Expedient.count + 1}"
    end

    def kind_s
      KIND[self.kind]
    end

    def status_s
      case status
      when 'new'
        'Nuevo'
      when 'process'
        'Proceso'
      else
        'Cerrado'
      end
    end

    def new?
      status == 'new'
    end

    def process?
      status == 'process'
    end

    def closed?
      status == 'closed'
    end

    def redirected?
      status == 'redirected'
    end

    def hours_passed
      ((Time.current - created_at) / 1.hour).round
    end

    def days_passed
      ((Time.current - created_at) / 1.day).round
    end

    def institution_name
      institution.name
    end

    def generate_reference_code(length = 6)
      generated_code = (0..length).map{ rand(36).to_s(36) }.join
      return generated_code unless self.class.exists?(reference_code: generated_code)

      generate_reference_code
    end

    def set_reference_code
      if self.reference_code.blank?
        self.reference_code = generate_reference_code.upcase
      end
    end

  end
end
