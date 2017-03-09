require 'sidekiq/web'

Rails.application.routes.draw do

  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq'
  end

  constraints subdomain: "hooks" do
    get   '/:integration_name' => 'webhooks#complete',  as: :complete_webhooks
    post  '/:integration_name' => 'webhooks#receive',   as: :receive_webhooks
  end

  get 'upgrade/index'
  get 'home/index'
  # get "/webhooks/receive", to: "webhooks#complete"

  match "/404", to: "errors#not_found",             via: :all
  match "/422", to: "errors#unacceptable",          via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  root to: "home#index"

  namespace :api do
    resources :users, only: [:index, :show], defaults: {format: 'json'}
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
