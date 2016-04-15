class CreateEmploymentsCountries < ActiveRecord::Migration
  def change
    create_table :employments_countries do |t|
      t.string :name
      t.timestamps
    end
  end
end
