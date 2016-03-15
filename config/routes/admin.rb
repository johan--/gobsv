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
        ],
        paa: [
          :financial_sources,
          :savings,
          :reports
        ]
      }

      namespaces.each do |ns, controllers|
        namespace ns do
          controllers.each do |controller|
            if ns == :paa and controller == :reports
              resources controller, only: [:index] do |c|
                get 'savings_by_financial_source', :on => :collection
              end
            else
              resources controller
            end            
          end
        end
      end

      resources :trash do
        get :restore, on: :member
      end
    end
  end
end
