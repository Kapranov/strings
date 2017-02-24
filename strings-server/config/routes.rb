Rails.application.routes.draw do
  get 'home/index'

  require 'sidekiq/web'

  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq'
  end

  %w( 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  constraints subdomain: "hooks" do
    get   '/:integration_name' => 'webhooks#complete',  as: :complete_webhooks
    post  '/:integration_name' => 'webhooks#receive',   as: :receive_webhooks
  end

  get 'upgrade/index'
  get 'home/index'
  # get "/webhooks/receive", to: "webhooks#complete"

  # root to: 'upgrade#index'
  root to: "home#index"

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
