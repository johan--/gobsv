class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country_id, :integer
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :alt_phone, :string
    add_column :users, :document_type, :string
    add_column :users, :document_number, :string
    add_column :users, :tax_id, :string
    add_attachment :users, :photo
    add_column :users, :user_created, :integer
    add_column :users, :user_edited, :integer
    add_column :users, :unknown_code, :string
    add_column :users, :username, :string
    add_column :users, :treatment, :string
    add_column :users, :address, :text
    add_index :users, :country_id    
  end
end
