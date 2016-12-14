domain = 'localhost.com'          if Rails.env.development?

constraints subdomain: 'paz' do
  scope module: 'agreements', as: 'agreements' do
    defaults subdomain: 'paz' do
      resources :dashboard, only: [:index, :create]
      root to: 'dashboard#index'
    end
  end
end