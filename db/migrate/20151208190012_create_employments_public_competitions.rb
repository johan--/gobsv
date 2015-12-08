class CreateEmploymentsPublicCompetitions < ActiveRecord::Migration
  def change
    create_table :employments_public_competitions do |t|
      t.string :identifier
      t.string :post_name
      t.string :convocation_id
      t.string :convocation_name
      t.string :institution_id
      t.string :institution_name
      t.string :institution_code
      t.boolean :autonomous, default: false
      t.references :plaza, index: true
      t.integer :plaza_state_id
      t.string :plaza_state
      t.integer :vacancies, default: 1
      t.decimal :salary, precision: 18, scale: 2
      t.datetime :opening_registration
      t.datetime :closing_registration
      t.string :inspto_code
      t.string :organization_department
      t.text :mission
      t.text :function
      t.text :result
      t.text :frame
      t.text :description
      t.string :email
      t.text :address
      t.string :phone
      t.text :comment
      t.datetime :created_date
      t.datetime :updated_date
      t.string :created_user
      t.string :updated_user
      t.timestamps
    end
  end
end
