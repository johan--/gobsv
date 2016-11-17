class CreateIndSnNotes < ActiveRecord::Migration
  def change
    create_table :ind_sn_notes do |t|
      t.references :note, index: true
      t.string :description
      t.integer :day
      t.integer :hour
      t.integer :minute
      t.integer :active
      t.timestamps null: false
    end
  end
end
