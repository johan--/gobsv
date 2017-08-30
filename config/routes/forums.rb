domain = 'calculatupension.info' if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'forums', as: 'forums' do

    root to: 'welcome#index'
    resources :themes
    resources :entries
    get '/calculator' => 'welcome#calculator'
    get '/download' => 'welcome#download'
    get '/subscribe' => 'welcome#subscribe'
    post '/save_subscriber' => 'welcome#save_subscriber'
  end
end
