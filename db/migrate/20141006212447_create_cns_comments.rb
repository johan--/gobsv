class CreateCnsComments < ActiveRecord::Migration
  def change
    create_table :cns_comments do |t|
      t.belongs_to :cns_proposals
      t.integer :active
      t.integer :featured
      t.string :email
      t.text :content
      t.timestamps
    end
  end
end
