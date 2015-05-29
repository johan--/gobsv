devise_for :admins,
  controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords'
  }

constraints subdomain: 'admin' do
  scope module: 'admin', as: 'admin' do
    defaults subdomain: 'admin' do
      root to: 'dashboard#index'

      namespaces = {
        ta: [
          :articles,
          :categories,
          :authors
        ]
      }

      namespaces.each do |ns, controllers|
        namespace ns do
          controllers.each do |controller|
            resources controller
          end
        end
      end

      resources :trash do
        get :restore, on: :member
      end
    end
  end
end
