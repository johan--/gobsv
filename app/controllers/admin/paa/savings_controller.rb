class Admin::Paa::SavingsController < Admin::PaaController

  def model
    ::Paa::Saving
  end

  def table_columns
    %w(institution_id created_at state financial_source_id)
  end

  def init_form
    @financial_sources = Paa::FinancialSource.order :name
    @institutions      = Institution.order :name
  end

  def item_params
    params.require(:paa_saving).permit(
      :year,
      :trimester,
      :state, 
      :institution_id,
      :financial_source_id, 
      :admin_id, 
      :start_at, 
      :end_at,
      :auditor_id, 
      :audit_comment, 
      :audited_at, 
      #tab1
      :remuneration,
      :cat_remuneration_frozen,
      :cat_remuneration_rescheduled,
      :remuneration_audited,
      :remuneration_actions, 
      :remuneration_explanation, 
      :remuneration_audit_explanation, 
      #tab2
      :food_products,
      :cat_procurement_of_goods_frozen,         
      :cat_procurement_of_goods_rescheduled,
      :cat_procurement_of_goods_and_services_frozen, 
      :cat_procurement_of_goods_and_services_rescheduled, 
      :food_products_audited,
      :food_products_actions, 
      :food_products_explanation, 
      :food_products_audit_explanation, 
      :textile_products,
      :textile_products_audited,
      :textile_products_actions, 
      :textile_products_explanation, 
      :textile_products_audit_explanation, 
      :fuels_products,
      :fuels_products_audited,
      :fuels_products_actions, 
      :fuels_products_explanation, 
      :fuels_products_audit_explanation, 
      :paper_products,
      :paper_products_audited,
      :paper_products_actions, 
      :paper_products_explanation, 
      :paper_products_audit_explanation,
      #tab3
      :basic_services,
      :cat_procurement_of_services_frozen,      
      :cat_procurement_of_services_rescheduled, 
      :basic_services_audited,
      :basic_services_actions, 
      :basic_services_explanation, 
      :basic_services_audit_explanation, 
      :social_services,
      :social_services_audited,
      :social_services_actions, 
      :social_services_explanation, 
      :social_services_audit_explanation, 
      :passages,
      :passages_audited,
      :passages_actions, 
      :passages_explanation, 
      :passages_audit_explanation, 
      :training_services,
      :training_services_audited,
      :training_services_actions, 
      :training_services_explanation, 
      :training_services_audit_explanation, 
      :ad_services,
      :ad_services_audited,
      :ad_services_actions, 
      :ad_services_explanation, 
      :ad_services_audit_explanation, 
      #tab4
      :financial_expenses,
      :cat_financial_expenses_and_other_frozen,      
      :cat_financial_expenses_and_other_rescheduled,  
      :financial_expenses_audited,
      :financial_expenses_actions, 
      :financial_expenses_explanation, 
      :financial_expenses_audit_explanation,
      #tab5
      :transfers,
      :cat_current_transfers_frozen,      
      :cat_current_transfers_rescheduled,  
      :transfers_audited,
      :transfers_actions, 
      :transfers_explanation, 
      :transfers_audit_explanation, 
      #tab6
      :investments,
      :cat_investment_in_fixed_assets_frozen,                              
      :cat_investment_in_fixed_assets_rescheduled,
      :investments_audited,
      :investments_actions, 
      :investments_explanation, 
      :investments_audit_explanation, 
    )
  end

end
