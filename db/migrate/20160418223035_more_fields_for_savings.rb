class MoreFieldsForSavings < ActiveRecord::Migration
  def change
    add_column :paa_savings, :cat_procurement_of_services_frozen,      :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_procurement_of_services_rescheduled, :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_procurement_of_goods_frozen,         :decimal, null: false, default: 0, precision: 18, scale: 2
    add_column :paa_savings, :cat_procurement_of_goods_rescheduled,    :decimal, null: false, default: 0, precision: 18, scale: 2
  end
end
