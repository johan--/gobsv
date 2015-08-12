constraints subdomain: 'empleos' do
  scope module: 'employments', as: 'employments' do
    defaults subdomain: 'empleos' do
      root to: 'dashboard#index'
    end
  end
end
