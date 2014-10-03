Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admin/sessions', passwords: 'admin/passwords' }

  constraints subdomain: 'consulta' do
    scope module: 'consulta', as: 'consulta' do
      defaults subdomain: 'consulta' do
        root to: 'dashboard#index'
      end
    end
  end

  constraints subdomain: 'apps.gobiernoabierto' do
    scope module: 'admin', as: 'admin' do
      defaults subdomain: 'admin' do

        root to: 'dashboard#index'

        resources :trash do
          get :restore, on: :member
        end

        [ :cns_categories,
          :cns_proposals,
          :cns_events,
          :cns_articles
        ].each do |resource|
          resources resource
        end

      end
    end
  end
  root :to => 'consulta/dashboard#index'

end
