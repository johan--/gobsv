class CreateTaAuthors < ActiveRecord::Migration
  def change
    create_table :ta_authors do |t|
      t.string :name
      t.string :twitter
      t.references :admin, index: true

      t.timestamps
    end
  end
end
