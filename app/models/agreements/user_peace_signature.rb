class Agreements::UserPeaceSignature < ActiveRecord::Base
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :name, :presence => true

  DEPARTMENTS = {
    'Exterior' => '-- Exterior --',
    'Ahuachapan' => 'Ahuachapán',
    'Cabañas' => 'Cabañas',
    'Chalatenango' => 'Chalatenango',
    'Cuscatlan' => 'Cuscatlán',
    'La Libertad' => 'La Libertad',
    'La Paz' => 'La Paz',
    'La Union' => 'La Unión',
    'Morazan' => 'Morazán',
    'San Miguel' => 'San Miguel',
    'San Salvador' => 'San Salvador',
    'San Vicente' => 'San Vicente',
    'Santa Ana' => 'Santa Ana',
    'Sonsonate' => 'Sonsonate',
    'Usulutan' => 'Usulután'
  }

end
