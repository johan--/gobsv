devise_for :admins,
  controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords'
  }

constraints subdomain: 'panel' do
  scope module: 'admin', as: 'admin' do
    defaults subdomain: 'panel' do
      root to: 'dashboard#index'

      namespaces = {
        ta: [
          :articles,
          :categories,
          :pages,
          :authors,
          :comments
        ],
        inv: [
          :products,
          :warehouses,
          :product_movements,
          :units
        ],
        req: [
          :requirements
        ],
        forum: [
          :themes,
          :organizations,
          :actors,
          :entries,
          :postures
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
