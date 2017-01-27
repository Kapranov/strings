require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  get 'upgrade/index'

  root to: 'upgrade#index'

  namespace :api do
    resources :users
  end

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        # resources :users
      end
      namespace :v2 do
        # resources :users
      end
      namespace :v3 do
      end
        # resources :users
    end
  end

end
