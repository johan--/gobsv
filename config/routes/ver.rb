domain = 'www.vosenred.com' if Rails.env.production?
#domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'ver', as: 'ver' do

    root to: 'welcome#index'
    resources :inscriptions, only: [:index, :create] do
      member do
        get 'thanks'
      end
    end
  end
end
