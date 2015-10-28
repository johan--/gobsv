constraints subdomain: 'quejas' do
  scope module: 'complaints', as: 'complaints' do
    defaults subdomain: 'quejas' do
      get 'search', to: 'dashboard#search', as: :search
      root to: 'dashboard#index'
      resources :expedients do
        resources :expedient_events, only: [:create]
      end
      resources :notifications, only: [:index]
    end
  end
end
