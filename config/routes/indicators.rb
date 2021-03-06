domain = 'sabesque.gob.sv' if Rails.env.production?
#domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'indicators', as: 'indicators' do
    root to: 'welcome#index'
    resources :general, only: [:index, :show] do
      collection do
        get :about
      end
    end
  end
end
