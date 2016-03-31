class AddAttachmentFieldToComplaintsExpedientsTable < ActiveRecord::Migration
  def change
    add_attachment :complaints_expedients, :asset
  end
end
