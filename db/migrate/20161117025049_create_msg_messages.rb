class CreateMsgMessages < ActiveRecord::Migration
  def change
    create_table :msg_messages do |t|
      t.string :name
      t.text :content
      t.references :group
      t.timestamps null: false
    end
  end
end
