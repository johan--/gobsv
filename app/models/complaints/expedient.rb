require 'complaints'
module Complaints
  class Expedient < ActiveRecord::Base

    KIND = {
      'email' => 'Correo electrónico',
      'ga' => 'Gobierno Abierto',
      'own' => 'Medios Propios de las instituciones del OE y Autónomas',
      '135' => 'Número 135',
      'other' => 'Otros',
      'press' => 'Prensa'
    }

  end
end
