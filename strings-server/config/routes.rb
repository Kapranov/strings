require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v3 do
      get 'users/index'
    end
  end

  namespace :api do
    namespace :v2 do
      get 'users/index'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'users/index'
    end
  end

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
