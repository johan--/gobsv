class Pensions::Subscriber < ActiveRecord::Base

  validates :name, :phone, presence: true
  validates :phone, length: { in: 8..12, messages: "El número debe contener minimo 8 digitos" }
  validates :phone, uniqueness: { messages: "Ya existe un registro con ese número de celular" }

end
