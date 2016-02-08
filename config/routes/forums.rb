domain = 'yvosquepensas.gobiernoabierto.gob.sv' if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'forums', as: 'forums' do

    root to: 'welcome#index'
    resources :themes
    resources :actors
    resources :organizations
    resources :postures
    resources :entries
  end
end
