class CreatePaaSavings < ActiveRecord::Migration
  def change
    create_table :paa_savings do |t|
      t.string :state, default: 'draft', index: true
      t.references :institution, index: true
      t.date :start_at
      t.date :end_at
      t.references :financial_source, index: true
      t.references :admin, index: true

      # Valores que ingresan los enlaces de las instituciones
      t.decimal :remuneration, null: false, default: 0, precision: 18, scale: 2
      t.decimal :food_products, null: false, default: 0, precision: 18, scale: 2
      t.decimal :textile_products, null: false, default: 0, precision: 18, scale: 2
      t.decimal :fuels_products, null: false, default: 0, precision: 18, scale: 2
      t.decimal :paper_products, null: false, default: 0, precision: 18, scale: 2
      t.decimal :basic_services, null: false, default: 0, precision: 18, scale: 2
      t.decimal :social_services, null: false, default: 0, precision: 18, scale: 2
      t.decimal :passages, null: false, default: 0, precision: 18, scale: 2
      t.decimal :training_services, null: false, default: 0, precision: 18, scale: 2
      t.decimal :ad_services, null: false, default: 0, precision: 18, scale: 2
      t.decimal :financial_expenses, null: false, default: 0, precision: 18, scale: 2
      t.decimal :transfers, null: false, default: 0, precision: 18, scale: 2
      t.decimal :investments, null: false, default: 0, precision: 18, scale: 2

      # Valores reales según auditoria
      t.decimal :remuneration_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :food_products_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :textile_products_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :fuels_products_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :paper_products_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :basic_services_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :social_services_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :passages_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :training_services_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :ad_services_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :financial_expenses_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :transfers_audited, null: false, default: 0, precision: 18, scale: 2
      t.decimal :investments_audited, null: false, default: 0, precision: 18, scale: 2

      # Explicaciones de los ahorros, según los enlaces de cada institución
      t.text :remuneration_explanation
      t.text :remuneration_actions
      t.text :food_products_explanation
      t.text :food_products_actions
      t.text :textile_products_explanation
      t.text :textile_products_actions
      t.text :fuels_products_explanation
      t.text :fuels_products_actions
      t.text :paper_products_explanation
      t.text :paper_products_actions
      t.text :basic_services_explanation
      t.text :basic_services_actions
      t.text :social_services_explanation
      t.text :social_services_actions
      t.text :passages_explanation
      t.text :passages_actions
      t.text :training_services_explanation
      t.text :training_services_actions
      t.text :ad_services_explanation
      t.text :ad_services_actions
      t.text :financial_expenses_explanation
      t.text :financial_expenses_actions
      t.text :transfers_explanation
      t.text :transfers_actions
      t.text :investments_explanation
      t.text :investments_actions

      # Explicación de la diferencia en los montos, según el auditor
      t.text :remuneration_audit_explanation
      t.text :food_products_audit_explanation
      t.text :textil_products_audit_explanation
      t.text :fuels_products_audit_explanation
      t.text :paper_products_audit_explanation
      t.text :basic_services_audit_explanation
      t.text :social_services_audit_explanation
      t.text :passages_audit_explanation
      t.text :training_services_audit_explanation
      t.text :ad_services_audit_explanation
      t.text :financial_expenses_audit_explanation
      t.text :transfers_audit_explanation
      t.text :investments_audit_explanation

      # Fecha de la auditoria y comentario
      t.references :auditor_id, index: true
      t.timestamp :audited_at
      t.text :audit_comment
      t.timestamps
    end
  end
end
