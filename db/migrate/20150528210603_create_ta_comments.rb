class CreateTaComments < ActiveRecord::Migration
  def change
    create_table :ta_comments do |t|
      t.references :article, index: true
      t.references :comment, index: true
      t.string :name
      t.string :email
      t.text :message
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
