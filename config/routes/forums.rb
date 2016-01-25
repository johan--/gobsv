#domain = 'forums.gob.sv' if Rails.env.production?
domain = 'localhost.com'          if Rails.env.development?

constraints DomainConstraint.new(domain) do
  scope module: 'forums', as: 'forums' do

    root to: 'welcome#index'
  end
end
