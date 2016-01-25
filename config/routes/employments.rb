#domain = 'empleospublicos.gob.sv' if Rails.env.production?
#domain = 'empleos.localhost.com'          if Rails.env.development?
domain = 'employments.localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'employments', as: 'employments' do

    root to: 'dashboard#index'
    resources :jobs, only: [:index, :show] do
      member do
        get :contact
      end
    end
  end
end
