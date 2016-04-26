class CreateEmploymentsPostulants < ActiveRecord::Migration
  def change
    create_table :employments_postulants do |t|
      t.integer :sttp_id
      t.integer :plaza_id
      t.string :identifier
      t.string :postulant_code
      t.integer :postulant_state_competition
      t.boolean :qualified
      t.boolean :vb_training
      t.boolean :vb_skills
      t.boolean :vb_experiences
      t.integer :created_user
      t.date :created_date
      t.integer :updated_user
      t.date :updated_date
      t.boolean :active, default: true
      t.timestamps null: false
    end
  end
end
