class AddIndexToOfciaPayrollsPeriodDate < ActiveRecord::Migration
  def change
    add_index :ofcia_payrolls, :period_date
  end
end
