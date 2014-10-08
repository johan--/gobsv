Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admin/sessions', passwords: 'admin/passwords' }

  constraints(Subdomain) do
  #constraints subdomain: 'consulta' do
    #scope module: 'consulta', as: 'consulta' do
      #defaults subdomain: 'consulta' do
        #root to: 'dashboard#index'
      #end
      scope module: 'consulta', as: 'consulta' do
        get '/' => 'dashboard#index'
        resources :cns_articles, only: [:index, :show]
        resources :cns_categories, only: [:index, :show] do
          resources :cns_proposals, only: [:index, :show] do
            resources :cns_comments
          end
        end
      end
    #end
  #end
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
          :cns_articles,
          :cns_timelines
        ].each do |resource|
          resources resource
        end

      end
    end
  end
  root :to => 'consulta/dashboard#index'

end
