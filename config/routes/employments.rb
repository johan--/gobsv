domain = 'empleospublicos.gob.sv' if Rails.env.production?
domain = 'empleos.localhost.com'          if Rails.env.development?
domain = 'employments.localhost.com'          if Rails.env.development?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  devise_for :users,
    controllers: {
      sessions: 'employments/sessions',
      registrations: 'employments/registrations',
      passwords: 'employments/passwords',
      omniauth_callbacks: 'employments/omniauth_callbacks'
    },
    path: 'auth',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'register',
      sign_up: 'signup'
    },
    constraints: { subdomain: 'employments' },
    defaults: { subdomain: 'employments' }

  scope module: 'employments', as: 'employments' do
    root to: 'dashboard#index'
    resources :jobs, only: [:index, :show] do
      member do
        get :contact
        get :apply
      end
      collection do
        get :progress
      end
    end
    resources :resumes, only: [:show] do
      collection do
        get :personal
      end
      member do
        post :save
      end
    end
  end
end
