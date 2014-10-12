Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: 'admin/sessions', passwords: 'admin/passwords' }

  devise_for :users,
              controllers: { sessions: 'user/sessions',  passwords: 'user/passwords', omniauth_callbacks: 'user/omniauth_callbacks' },
              path: 'auth',
              path_names: { sign_in: 'login', sign_out: 'logout' },
              constraints: { subdomain: 'user' },
              defaults: { subdomain: 'user' }

  constraints subdomain: 'user' do
    scope module: 'user', as: 'user' do
      defaults subdomain: 'user' do
        root to: 'dashboard#index'
      end
    end
  end

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
        resources :cns_events, only: [:index, :show]
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
