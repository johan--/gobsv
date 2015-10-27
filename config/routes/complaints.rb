constraints subdomain: 'quejas' do
  scope module: 'complaints', as: 'complaints' do
    defaults subdomain: 'quejas' do
      get 'search', to: 'dashboard#search', as: :search
      root to: 'dashboard#index'
      resources :expedients do
      end
      resources :notifications, only: [:index]
    end
  end
end
