class CreateEmploymentsDegrees < ActiveRecord::Migration
  def change
    create_table :employments_degrees do |t|
      t.references :plaza, index: true
      t.string :gra_code
      t.string :gra_name
      t.string :req_code
      t.string :req_name
      t.timestamps
    end
  end
end
