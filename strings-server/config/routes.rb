require 'sidekiq/web'

Rails.application.routes.draw do
  get 'upgrade/index'
  root to: 'upgrade#index'
  mount Sidekiq::Web, at: '/sidekiq'
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
