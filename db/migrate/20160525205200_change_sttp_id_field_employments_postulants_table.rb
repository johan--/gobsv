class ChangeSttpIdFieldEmploymentsPostulantsTable < ActiveRecord::Migration
  def change
    rename_column :employments_postulants, :sttp_id, :stpp_id
  end
end
