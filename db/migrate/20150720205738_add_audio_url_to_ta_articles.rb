class AddAudioUrlToTaArticles < ActiveRecord::Migration
  def change
    add_column :ta_articles, :audio_url, :string, null: false, default: ''
  end
end
