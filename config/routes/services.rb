domain = 'serv.gobiernoabierto.gob.sv' if Rails.env.production?
domain = 'serv.localhost.com'          if Rails.env.development?

constraints subdomain: 'services' do
  scope module: 'serv', as: 'serv' do
    defaults subdomain: 'services' do

      mount_devise_token_auth_for 'Admin', at: 'auth'

      resources :rooms do
        resources :meets, only: [:index]
      end

      resources :meets do
        collection do
          get 'booking/:room_id/:year/:month/:day/:hour/:minute', action: :booking, as: :booking
          get 'week/:room_id/:year/:month/:day/:hour/:minute',    action: :week,    as: :week
        end
      end
    end
  end
end
