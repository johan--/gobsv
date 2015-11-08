class CreateInvUnits < ActiveRecord::Migration
  def change
    create_table :inv_units do |t|
      t.string :name, null: false, default: ''

      t.timestamps
    end
  end
end
