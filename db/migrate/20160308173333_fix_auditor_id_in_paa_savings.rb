class FixAuditorIdInPaaSavings < ActiveRecord::Migration
  def change
    rename_column :paa_savings, :auditor_id_id, :auditor_id
  end
end
