domain = 'transparenciaactiva.gob.sv' if Rails.env.production?
domain = 'localhost.com'           if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'ta', as: 'ta' do
    root to: 'categories#index'

    resources :articles, only: [:index] do
      resources :comments, only: [:create]
      collection do
        get 'galleries'
      end
    end
    get '/:id', to: 'articles#show', as: :article
    resources :categories, only: [:show]
    resources :pages, only: [:show]
  end
end
