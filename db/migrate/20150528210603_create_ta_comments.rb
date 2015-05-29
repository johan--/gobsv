class CreateTaComments < ActiveRecord::Migration
  def change
    create_table :ta_comments do |t|
      t.references :article, index: true
      t.references :comment, index: true
      t.string :name
      t.string :email
      t.text :comment
      t.integer :status

      t.timestamps
    end
  end
end
