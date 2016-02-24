class CreatePaaFinancialSources < ActiveRecord::Migration
  def change
    create_table :paa_financial_sources do |t|
      t.string :name
      t.timestamps
    end
  end
end
