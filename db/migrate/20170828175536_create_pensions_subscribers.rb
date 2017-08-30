class CreatePensionsSubscribers < ActiveRecord::Migration
  def change
    create_table :pensions_subscribers do |t|
      t.string :name
      t.string :phone
      t.timestamps null: false
    end
  end
end
