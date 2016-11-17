#domain = 'localhost.com'          if Rails.env.development?

constraints subdomain: 'servicios' do
  scope module: 'goverment_services', as: 'goverment_services' do
    defaults subdomain: 'servicios' do

      root to: 'welcome#index'

      resources :institution_services, only: [:index, :show]      
    end
  end
end