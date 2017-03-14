Rails.application.routes.draw do

  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq'
  end

  constraints subdomain: "hooks" do
    get   '/:integration_name' => 'webhooks#complete',  as: :complete_webhooks
    post  '/:integration_name' => 'webhooks#receive',   as: :receive_webhooks
  end

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :users,   only: [:index], defaults: {format: 'json'}
        resources :rooms,   only: [:index], defaults: {format: 'json'}
        resources :cards,   only: [:index], defaults: {format: 'json'}
        resources :phones,  only: [:index], defaults: {format: 'json'}
      end
      namespace :v2 do
        resources :users,   only: [:index], defaults: {format: 'json'}
        resources :rooms,   only: [:index], defaults: {format: 'json'}
        resources :cards,   only: [:index], defaults: {format: 'json'}
        resources :phones,  only: [:index], defaults: {format: 'json'}
      end
      namespace :v3 do
        resources :users,   only: [:index], defaults: {format: 'json'}
        resources :rooms,   only: [:index], defaults: {format: 'json'}
        resources :cards,   only: [:index], defaults: {format: 'json'}
        resources :phones,  only: [:index], defaults: {format: 'json'}
      end
    end
  end

  resources :home,        only: [:index, :show], defaults: {format: 'json'}
  resources :upgrade,     only: [:index], defaults: {format: 'json'}
  resources :dashboards,  only: [:index], defaults: {format: 'json'}
  resources :profiles,    only: [:index], defaults: {format: 'json'}
  resources :rooms,       only: [:index, :show, :create, :destroy], defaults: {format: 'json'}
  resources :cards,       only: [:index, :show, :create, :destroy, :update], defaults: {format: 'json'}
  resources :users,       only: [:index, :show, :create, :destroy, :update], defaults: {format: 'json'} do
    resources :phones, defaults: {format: 'json'}
  end

  post 'login',     to: 'authentication#login', defaults: {format: 'json'}
  post 'register',  to: 'authentication#register', defaults: {format: 'json'}

  root to: 'home#index', defaults: {format: 'json'}

  match "/404", to: "errors#not_found",             via: :all, defaults: {format: 'json'}
  match "/422", to: "errors#unacceptable",          via: :all, defaults: {format: 'json'}
  match "/500", to: "errors#internal_server_error", via: :all, defaults: {format: 'json'}
end
