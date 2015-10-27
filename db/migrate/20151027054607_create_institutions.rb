class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.integer :institution_type_id
      t.string :acronym
      t.boolean :ranked
      t.boolean :at_complaints
      t.string :slug
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      t.string :header_file_name
      t.string :header_content_type
      t.integer :header_file_size
      t.datetime :header_updated_at
      t.boolean :at_information_requests
      t.boolean :accepts_online_information_requests
      t.integer :information_standard_category_id
      t.integer :information_request_correlative
      t.string :transparency_external_portal_url
      t.boolean :highlight_events
      t.timestamps
    end
    add_index :institutions, :slug
    add_index :institutions, :information_standard_category_id
    add_index :institutions, :institution_type_id

  end
end
