class Paa::Saving < ActiveRecord::Base

  STATE = {
    'draft' => 'Borrador',
    'evaluation' => 'En evaluación',
    'evaluated' => 'Evaluado'
  }

end
