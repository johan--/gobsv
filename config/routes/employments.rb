domain = 'empleospublicos.gob.sv' if Rails.env.production?
domain = 'empleos.localhost.com'          if Rails.env.development?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'employments', as: 'employments' do

    root to: 'dashboard#index'
    resources :jobs, only: [:index, :show] do
      member do
        get :contact
      end
    end
    resources :resumes, only: [:show] do
      collection do
        get :personal_resume
        post :save
      end
    end
  end
end
