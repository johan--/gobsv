constraints DomainConstraint.new('transparenciaactiva.com') do
  scope module: 'ta', as: 'ta' do
    root to: 'articles#index'

    get '/:id', to: 'articles#show', as: :article
    resources :articles, except: [:show] do
      resources :comments, only: [:create]
    end
    resources :categories, only: [:show]
  end
end
