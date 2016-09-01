domain = 'servicios.gobiernoabierto.gob.sv' if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'goverment_services', as: 'goverment_services' do

    root to: 'welcome#index'

    resources :institution_services, only: [:index, :show]

  end
end
