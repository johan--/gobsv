#domain = 'localhost.com'          if Rails.env.development?

constraints subdomain: 'quejas' do
  scope module: 'complaints', as: 'complaints' do
    defaults subdomain: 'quejas' do
      get 'search', to: 'dashboard#search', as: :search
      root to: 'dashboard#index'
      resources :expedients do
        resources :expedient_events, only: [:create]
        resources :expedient_managements, only: [:create]
      end
      resources :notifications, only: [:index]
      resources :users
      resources :assets
      resources :expedient_managements, only: [] do
        resources :expedient_management_events, only: [:create]
        resources :expedient_management_comments, only: [:create]
      end
    end
  end
end
