require 'complaints'
module Complaints
  class Expedient < ActiveRecord::Base
    has_many :events, class_name: '::Complaints::ExpedientEvent', dependent: :destroy
    has_many :managements, class_name: '::Complaints::ExpedientManagement', dependent: :destroy

    scope :newer, -> { order(received_at: :desc) }
    scope :status, -> (status) { where(status: status) }


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

    def new?
      status == 'new'
    end

    def process?
      status == 'process'
    end

    def closed?
      status == 'closed'
    end

  end
end
