class AddFieldsToExpedientManagementsTable < ActiveRecord::Migration
  def change
    add_column :complaints_expedient_managements, :weight, :integer, default: 1
    add_column :complaints_expedient_managements, :closed_as, :string
  end
end
