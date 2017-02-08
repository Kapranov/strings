Rails.application.routes.draw do
  require 'sidekiq/web'

  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq'
  end

  get 'upgrade/index'
  get "application/index"

  # root to: 'upgrade#index'
  root to: "application#index"

  namespace :api do
    resources :users, only: [:index], defaults: {format: 'json'}
  end

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :users, only: [:index], defaults: {format: 'json'}
      end
      namespace :v2 do
        get 'users/index', defaults: {format: 'json'}
      end
      namespace :v3 do
        get 'users/index', defaults: {format: 'json'}
      end
    end
  end

end
