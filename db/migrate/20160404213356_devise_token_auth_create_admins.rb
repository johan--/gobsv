class DeviseTokenAuthCreateAdmins < ActiveRecord::Migration
  def up
    add_column :admins, :provider, :string, null: false, default: 'email'
    add_column :admins, :uid, :string, null: false, default: ''
    add_column :admins, :tokens, :text

    Admin.all.each do |admin|
      admin.update_column :uid, admin.email
    end
  end

  def down
    remove_column :admins, :provider
    remove_column :admins, :uid
    remove_column :admins, :tokens
  end
end
