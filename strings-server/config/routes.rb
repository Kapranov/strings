require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  get 'upgrade/index'

  #root to: 'upgrade#index'

  namespace :api do
    resources :users
  end

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        # get 'users/index'
        resources :users, only: [:index], defaults: {format: 'json'}
      end
      namespace :v2 do
        get 'users/index'
      end
      namespace :v3 do
        get 'users/index'
      end
    end
  end

end
