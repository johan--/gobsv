devise_for :users,
  controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords',
    omniauth_callbacks: 'user/omniauth_callbacks'
  },
  path: 'auth',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'register',
    sign_up: 'signup'
  },
  constraints: { subdomain: 'user' },
  defaults: { subdomain: 'user' }

constraints subdomain: 'user' do
  scope module: 'user', as: 'user' do
    defaults subdomain: 'user' do
      root to: 'dashboard#index'
    end
  end
end
