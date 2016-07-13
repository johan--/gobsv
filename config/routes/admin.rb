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
          :reports,
          :holders
        ],
        ofcia: [
          :payrolls,
          :payroll_views
        ]
      }

      namespaces.each do |ns, controllers|
        namespace ns do
          controllers.each do |controller|
            if ns == :paa && controller == :reports
              resources controller, only: [:index] do |c|
                get 'savings_by_financial_source_unaudited',                      :on => :collection
                get 'savings_by_financial_source_audited',                        :on => :collection
                get 'funds_generated_by_the_institutions_of_the_executive_organ', :on => :collection
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
