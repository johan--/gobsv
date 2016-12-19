class AddAndChangeFieldsToUserPeaceSignatures < ActiveRecord::Migration
  def change
    rename_column :agreements_user_peace_signatures, :place, :country
    add_column :agreements_user_peace_signatures, :state, :string
  end
end
