Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admin/sessions', passwords: 'admin/passwords' }

  constraints subdomain: 'consulta' do
    scope module: 'consulta', as: 'consulta' do
      defaults subdomain: 'consulta' do
        root to: 'cns_categories#index'
        resources :cns_categories
      end
    end
  end

  constraints subdomain: 'admin' do
    scope module: 'admin', as: 'admin' do
      defaults subdomain: 'admin' do
        root to: 'dashboard#index'
        resources :cns_categories
        resources :cns_proposals
        resources :cns_events
      end
    end
  end

end
