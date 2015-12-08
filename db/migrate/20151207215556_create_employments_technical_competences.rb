class CreateEmploymentsTechnicalCompetences < ActiveRecord::Migration
  def change
    create_table :employments_technical_competences do |t|
      t.references :plaza, index: true
      t.string :name
      t.string :req_code
      t.string :req_name
      t.timestamps
    end
  end
end
