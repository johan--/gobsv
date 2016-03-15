class Paa::Saving < ActiveRecord::Base

  scope :draft,      -> { where(state: 'draft') }
  scope :evaluation, -> { where(state: 'evaluation') }
  scope :evaluated,  -> { where(state: 'evaluated') }

  STATE = {
    'draft'      => 'Borrador',
    'evaluation' => 'En evaluación',
    'evaluated'  => 'Evaluado'
  }
  
  SAVING_CATEGORY_UNAUDITED = {
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

  SAVING_CATEGORY_AUDITED = {
    'Remuneraciones' => [
      :remuneration_audited
    ], 
    'Adquisiciones de Bienes y Servicios' => [
      :food_products_audited,
      :textile_products_audited,
      :fuels_products_audited,
      :paper_products_audited,
      :basic_services_audited,
      :social_services_audited,
      :passages_audited,
      :training_services_audited,
      :ad_services_audited
    ],
    'Gastos Financieros y Otros' => [
      :financial_expenses_audited      
    ],
    'Transferencias Corrientes' => [
      :transfers_audited
    ],
    'Inversión en Activos Fijos' => [
      :investments_audited
    ]
  }

  def self.savings_by(institution_id, financial_source_id, fields = [])
    r = 0
    scope = self.evaluated
      fields.each do |f|
      
      if !institution_id.nil?
        scope = scope.where(:institution_id => institution_id)
      end
      
      if !financial_source_id.nil?
        scope = scope.where(:financial_source_id => financial_source_id) 
      end
    
      scope = scope.sum(f)
    
      r += scope.to_f
      
      scope = self.evaluated
    end
    r
  end
end
