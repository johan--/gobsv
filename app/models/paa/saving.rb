class DupTrimesterValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)

    object.send :set_start_at, object.year.to_i, value.to_i
    object.send :set_end_at, object.year.to_i, value.to_i
    id = object.id
    
    if id.nil?
      q = Paa::Saving.where("institution_id = ? and financial_source_id = ? and start_at = ? and end_at = ?", object.institution_id, object.financial_source_id, object.start_at, object.end_at).count
    else
      q = Paa::Saving.where("institution_id = ? and financial_source_id = ? and start_at = ? and end_at = ? and id <> ?", object.institution_id, object.financial_source_id, object.start_at, object.end_at, id).count
    end
    
    if q > 0

      object.errors[attribute] << (options[:message] || I18n.t("labels.trimester_duplicated"))
    end
  end
end

class RemunerationValueValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    
    case attribute
    when :cat_remuneration_frozen
      total = object.cat_remuneration_total
    when :cat_procurement_of_goods_frozen
      total = object.cat_procurement_of_goods_total
    when :cat_procurement_of_services_frozen
      total = object.cat_procurement_of_services_total
    when :cat_financial_expenses_and_other_frozen
      total = object.cat_financial_expenses_and_other_total
    when :cat_current_transfers_frozen
      total = object.cat_current_transfers_total
    when :cat_investment_in_fixed_assets_frozen
      total = object.cat_investment_in_fixed_assets_total
    when :cat_procurement_of_goods_and_services_frozen
      total = object.cat_procurement_of_goods_and_services_total
    end
    
    if (value > total)
      object.errors[attribute] << (options[:message] || I18n.t("labels.frozen_value_too_high"))
    end
  end
end

class Paa::Saving < ActiveRecord::Base

  before_save :set_start_at, :set_end_at, :set_cat_remuneration_rescheduled, :set_cat_procurement_of_goods_rescheduled, :set_cat_procurement_of_services_rescheduled, :set_cat_procurement_of_goods_and_services_rescheduled, :set_cat_financial_expenses_and_other_rescheduled, :set_cat_current_transfers_rescheduled, :set_cat_investment_in_fixed_assets_rescheduled
  
  scope :draft,      -> { where(state: 'draft') }
  scope :evaluation, -> { where(state: 'evaluation') }
  scope :evaluated,  -> { where(state: 'evaluated') }

  #fake_fields
  attr_accessor :trimester
  attr_accessor :year
  
  #sum_fields
  attr_accessor :cat_remuneration_total
  attr_accessor :cat_financial_expenses_and_other_total
  attr_accessor :cat_current_transfers_total
  attr_accessor :cat_investment_in_fixed_assets_total
  
  belongs_to :institution
  belongs_to :financial_source, class_name: '::Paa::FinancialSource'
  belongs_to :holder, class_name: '::Paa::Holder'

  #ufi
  validates_numericality_of :remuneration, :food_products, :textile_products, :fuels_products, :paper_products, :basic_services, :social_services, :passages, :training_services, :ad_services, :financial_expenses, :transfers, :investments, :cat_procurement_of_services_frozen, :cat_procurement_of_services_rescheduled, :cat_procurement_of_goods_frozen, :cat_procurement_of_goods_rescheduled, :cat_remuneration_frozen, :cat_procurement_of_goods_and_services_frozen, :cat_financial_expenses_and_other_frozen, :cat_current_transfers_frozen, :cat_investment_in_fixed_assets_frozen, :cat_remuneration_rescheduled, :cat_procurement_of_goods_and_services_rescheduled, :cat_financial_expenses_and_other_rescheduled, :cat_current_transfers_rescheduled, :cat_investment_in_fixed_assets_rescheduled, :greater_than_or_equal_to => 0

  #auditor

  
  validates :trimester, :presence => true, :dup_trimester => true
  validates :state, :year, :institution_id, :financial_source_id, :presence => true
  validates :cat_remuneration_frozen, :cat_procurement_of_goods_frozen, :cat_procurement_of_services_frozen, :cat_financial_expenses_and_other_frozen, :cat_current_transfers_frozen, :cat_investment_in_fixed_assets_frozen, :cat_procurement_of_goods_and_services_frozen, :remuneration_value => true

  STATE = {
    'draft'      => 'Borrador',
    'evaluation' => 'En evaluación',
    'evaluated'  => 'Evaluado'
  }
  
  TRIMESTER = {
    '1' => 'Primero',
    '2' => 'Segundo',
    '3' => 'Tercero',
    '4' => 'Cuarto',
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

  def get_trimester
    tmp_start_at = self.start_at
    tmp_end_at   = self.end_at
    r = [0,0]
    if !tmp_start_at.nil? and !tmp_end_at.nil?
      start_year = tmp_start_at.strftime("%Y").to_i
      end_year   = tmp_end_at.strftime("%Y").to_i
      
      if start_year == end_year
        y           = start_year
        start_month = tmp_start_at.strftime("%m").to_i 
        end_month   = tmp_end_at.strftime("%m").to_i
        
        if start_month == 1 and end_month == 3
          m = 1
        end
        
        if start_month == 4 and end_month == 6
          m = 2
        end
        
        if start_month == 7 and end_month == 9
          m = 3
        end
        
        if start_month == 10 and end_month == 12
          m = 4
        end
        
        r = [y, m]
      end
      
    end
    r
  end

  def cat_remuneration_total
    @cat_remuneration_total = remuneration
  end

  def cat_procurement_of_goods_total
    @cat_procurement_of_goods_total = food_products + textile_products + fuels_products + paper_products
  end
  
  def cat_procurement_of_services_total
    @cat_procurement_of_services_total = basic_services + social_services + passages + training_services + ad_services
  end
  
  def cat_procurement_of_goods_and_services_total
    @cat_procurement_of_goods_and_services_total = food_products + textile_products + fuels_products + paper_products + basic_services + social_services + passages + training_services + ad_services
  end

  def cat_financial_expenses_and_other_total
    @cat_financial_expenses_and_other_total = financial_expenses
  end
  
  def cat_current_transfers_total
    @cat_current_transfers_total = transfers
  end
  
  def cat_investment_in_fixed_assets_total
    @cat_investment_in_fixed_assets_total = investments
  end

  private
    def set_start_at(tmp_year=self.year, tmp_trimester=self.trimester)
      if [1,2,3,4].include? tmp_trimester

        case tmp_trimester
        when 1
          tmp_month = 1
        when 2
          tmp_month = 4
        when 3
          tmp_month = 7
        when 4
          tmp_month = 10
        end
        self.start_at = Date.new(tmp_year, tmp_month, 1)
      end
    end
    
    def set_end_at(tmp_year=self.year, tmp_trimester=self.trimester)
      if [1,2,3,4].include? tmp_trimester
        last_day = 30

        case tmp_trimester
        when 1
          tmp_month = 3
          last_day = 31
        when 2
          tmp_month = 6
        when 3
          tmp_month = 9
        when 4
          tmp_month = 12
          last_day = 31
        end
        self.end_at = Date.new(tmp_year, tmp_month, last_day)
      end
    end
    
  def set_cat_remuneration_rescheduled
    self.cat_remuneration_rescheduled = cat_remuneration_total - cat_remuneration_frozen
  end

  def set_cat_procurement_of_goods_rescheduled
    self.cat_procurement_of_goods_rescheduled = cat_procurement_of_goods_total - cat_procurement_of_goods_frozen
  end
  
  def set_cat_procurement_of_services_rescheduled
    self.cat_procurement_of_services_rescheduled = cat_procurement_of_services_total - cat_procurement_of_services_frozen
  end
  
  def set_cat_procurement_of_goods_and_services_rescheduled
    self.cat_procurement_of_goods_and_services_rescheduled = cat_procurement_of_goods_and_services_total - cat_procurement_of_goods_and_services_frozen
  end

  def set_cat_financial_expenses_and_other_rescheduled
    self.cat_financial_expenses_and_other_rescheduled = cat_financial_expenses_and_other_total - cat_financial_expenses_and_other_frozen
  end
  
  def set_cat_current_transfers_rescheduled
    self.cat_current_transfers_rescheduled = cat_current_transfers_total - cat_current_transfers_frozen
  end
  
  def set_cat_investment_in_fixed_assets_rescheduled
    self.cat_investment_in_fixed_assets_rescheduled = cat_investment_in_fixed_assets_total - cat_investment_in_fixed_assets_frozen
  end

end
