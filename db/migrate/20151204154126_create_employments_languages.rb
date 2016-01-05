class CreateEmploymentsLanguages < ActiveRecord::Migration
  def change
    create_table :employments_languages do |t|
      t.references :plaza, index: true
      t.string :idi_code
      t.string :idi_name
      t.string :req_code
      t.string :req_name
      t.timestamps
    end
  end
end
