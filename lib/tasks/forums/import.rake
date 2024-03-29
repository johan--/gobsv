require 'csv';
namespace :forums do
  desc 'Import entries from csv'
  task :import_entries => [:environment] do
    file = "#{Rails.root}/db/carga.csv"
    CSV.foreach(file, headers: true) do |row|
      entries_hash = row.to_hash
      entry = Forum::Entry.new
      entry.kind = case entries_hash['Tipo'].to_s
      when 'tweet'
        'twitter'
      else
        'article'
      end
      organization = Forum::Organization.where(name: entries_hash['Medio']).first_or_create
      fecha = entries_hash['Fecha'].split('/')
      entry.entry_at = Date.parse("#{fecha[2]}-#{fecha[1]}-#{fecha[0]}")
      entry.title = entries_hash['Titulo']
      entry.description = entries_hash['Descripcion']
      entry.organization_id = organization.id
      entry.url = entries_hash['URL']
      entry.theme_id = Forum::Theme.first.id
      entry.save
      #puts entry.errors.full_messages
    end # end CSV.foreach
  end
end
