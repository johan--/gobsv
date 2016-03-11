class Paa::Saving < ActiveRecord::Base

  STATE = {
    'draft' => 'Borrador',
    'evaluation' => 'En evaluación',
    'evaluated' => 'Evaluado'
  }
  
  SAVING_CATEGORY = {
    'remunerations' => [
      :remuneration
    ], 
    'procurement of goods and services' => [
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
    'financial expenses and other' => [
      :financial_expenses      
    ],
    'current and capital transfers' => [
      :transfers
    ],
    'capital expenditures' => [
      :investments
    ]
  }

  def self.savings_by_financial_source(id, fields = [])
    r = 0
    fields.each do |f|
      r += self.where(:financial_source_id => id).sum(f).to_f
    end
    r
  end
end
