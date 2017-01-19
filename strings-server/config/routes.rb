Rails.application.routes.draw do
  get 'snippets/index'
  root to: 'snippets#index'
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        # Version #1
      end
      namespace :v2 do
        # Version #2
      end
      namespace :v3 do
        # Version #3
      end
    end
  end
end
