class AddFieldsToSavings < ActiveRecord::Migration
  def change
    #frozen values
    add_column :paa_savings, :cat_remuneration_frozen,                      :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_procurement_of_goods_and_services_frozen, :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_financial_expenses_and_other_frozen,      :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_current_transfers_frozen,                 :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_investment_in_fixed_assets_frozen,        :decimal, null: false, default: 0, precision: 18, scale: 2
    #rescheduled values
    add_column :paa_savings, :cat_remuneration_rescheduled,                      :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_procurement_of_goods_and_services_rescheduled, :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_financial_expenses_and_other_rescheduled,      :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_current_transfers_rescheduled,                 :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_investment_in_fixed_assets_rescheduled,        :decimal, null: false, default: 0, precision: 18, scale: 2
  end
end
