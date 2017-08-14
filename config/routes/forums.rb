domain = 'calculatupension.info' if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'forums', as: 'forums' do

    root to: 'welcome#calculator'
    resources :themes
    resources :entries
    get '/calculator' => 'welcome#calculator'
    get '/download' => 'welcome#download'
  end
end
