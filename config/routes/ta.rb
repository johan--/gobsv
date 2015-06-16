domain = 'transparenciaactiva.gob.sv' if Rails.env.production?
domain = 'localhost.com'              if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'ta', as: 'ta' do
    root to: 'articles#index'

    get '/:id', to: 'articles#show', as: :article
    resources :articles, except: [:show] do
      resources :comments, only: [:create]
    end
    resources :categories, only: [:show]
  end
end
