domain = 'micompromisoporlapaz.com'    if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'agreements', as: 'agreements' do
    resources :dashboard, only: [:index, :create] do
      member do
        get 'get_states'
      end
    end
    root to: 'dashboard#index'
  end
end
