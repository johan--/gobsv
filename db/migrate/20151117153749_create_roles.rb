class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, null: false, default: nil
      t.json :activities

      t.timestamps
    end
  end
end
