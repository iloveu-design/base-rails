Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => :omniauth_callbacks
  }
  resources :users do
    resources :notifications, shallow: true
    member do
      post :follow
      post :unfollow
    end
  end
  resources :subscriptions

  get 'pages/terms'
  get 'pages/privacy'

  root 'pages#home'

  namespace :admin, path: 'radmin' do
    root 'subscriptions#index'

    resources :users do
      collection do
        get :hibernated
      end
    end
    resources :notifications
    resources :subscriptions

    resources :spaces do
      member do
        get :delete_file
      end
    end
    resources :reservations

    resources :boards
    resources :board_posts do
      resources :comments, module: :board_posts
    end

    resources :policies
    resources :settings
    resources :assets, only: [:create, :destroy]

    if Rails.env.development? || Rails.env.staging?
      require 'sidekiq/web'
      require 'sidekiq/cron/web'
      mount Sidekiq::Web => '/sidekiq'
      mount LetterOpenerWeb::Engine, at: "/emails"
    end
  end
end