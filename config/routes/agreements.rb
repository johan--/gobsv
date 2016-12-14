domain = 'paz.gobiernoabierto.gob.sv' if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'agreements', as: 'agreements' do
    resources :dashboard, only: [:index, :create]
    root to: 'dashboard#index'
  end
end
