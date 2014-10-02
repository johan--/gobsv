Rails.application.routes.draw do

  constraints subdomain: 'consulta' do
    scope module: 'consulta', as: 'consulta' do
      defaults subdomain: 'consulta' do
        root to: 'dashboard#index'
      end
    end
  end

  constraints subdomain: 'admin' do
    scope module: 'admin', as: 'admin' do
      defaults subdomain: 'admin' do
        root to: 'dashboard#index'
        resources :cns_categories
        resources :cns_proposals
      end
    end
  end

end
