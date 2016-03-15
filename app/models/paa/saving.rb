class Paa::Saving < ActiveRecord::Base

  scope :evaluated, -> { where(state: 'evaluated') }

  STATE = {
    'draft'      => 'Borrador',
    'evaluation' => 'En evaluación',
    'evaluated'  => 'Evaluado'
  }
  
  SAVING_CATEGORY = {
    'Remuneraciones' => [
      :remuneration
    ], 
    'Adquisiciones de Bienes y Servicios' => [
      :food_products,
      :textile_products,
      :fuels_products,
      :paper_products,
      :basic_services,
      :social_services,
      :passages,
      :training_services,
      :ad_services
    ],
    'Gastos Financieros y Otros' => [
      :financial_expenses      
    ],
    'Transferencias Corrientes' => [
      :transfers
    ],
    'Inversión en Activos Fijos' => [
      :investments
    ]
  }

  def self.savings_by_financial_source(id, fields = [])
    r = 0
      fields.each do |f|
      if id.nil?
        query = self.evaluated.sum(f).to_f
      else
        query = self.evaluated.where(:financial_source_id => id).sum(f).to_f
      end
      r += query
    end
    r
  end
end
