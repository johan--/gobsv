class CreateVerInscriptions < ActiveRecord::Migration
  def change
    create_table :ver_inscriptions do |t|
      t.string :location
      t.string :email
      t.string :firstname
      t.string :lastname
      t.integer :age
      t.timestamps null: false
    end
  end
end
