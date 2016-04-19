domain = 'empleospublicos.gob.sv' if Rails.env.production?
domain = 'empleos.localhost.com'          if Rails.env.development?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  devise_scope :users do
    get '/auth/login' => 'employments/sessions#new', as: :employments_new_user_session
    post '/auth/login'  => 'employments/sessions#create',  as: :employments_user_session
  end
  scope module: 'employments', as: 'employments' do
    root to: 'dashboard#index'
    resources :jobs, only: [:index, :show] do
      member do
        get :contact
        get :apply
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
