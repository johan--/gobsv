constraints subdomain: 'pensiones' do
  scope module: 'pensions', as: 'pensions' do
    defaults subdomain: 'pensiones' do
      root to: 'dashboard#index'
    end
  end
end
