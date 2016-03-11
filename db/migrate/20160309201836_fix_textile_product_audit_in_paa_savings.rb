class FixTextileProductAuditInPaaSavings < ActiveRecord::Migration
  def change
      rename_column :paa_savings, :textil_products_audit_explanation, :textile_products_audit_explanation
  end
end
