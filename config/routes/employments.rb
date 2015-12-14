constraints subdomain: 'empleos' do
  scope module: 'employments', as: 'employments' do
    defaults subdomain: 'empleos' do
      root to: 'dashboard#index'
      resources :jobs, only: [:index, :show] do
        member do
          get :contact
        end
      end
    end
  end
end
