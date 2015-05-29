constraints subdomain: 'www' do
  scope module: 'www', as: 'www' do
    defaults subdomain: 'www' do
      root to: 'dashboard#index'
    end
  end
end
