Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => :omniauth_callbacks
  }

  root 'pages#home'

  resources :subscriptions

  get 'pages/terms'
  get 'pages/privacy'

  namespace :admin do
    root 'subscriptions#index'

    resources :users do
      collection do
        get :hibernated
      end
    end

    resources :spaces do
      member do
        get :delete_file
      end
    end
    resources :reservations

    resources :boards
    resources :board_posts

    resources :policies
    resources :subscriptions

    resources :assets, only: [:create, :destroy]

    if Rails.env.development? || Rails.env.staging?
      require 'sidekiq/web'
      require 'sidekiq/cron/web'
      mount Sidekiq::Web => '/sidekiq'
      mount LetterOpenerWeb::Engine, at: "/emails"
    end
  end
end