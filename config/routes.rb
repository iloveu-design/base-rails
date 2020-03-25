Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'user/registrations',
    :omniauth_callbacks => :omniauth_callbacks
  }

  if Rails.env.development? || Rails.env.staging?
    get "dev_login/:id", controller: 'pages', action: 'dev_login'
  end

  resources :users do
    resources :notifications, shallow: true
    member do
      post :follow
      post :unfollow
    end
  end

  resources :inquiries, only: [:new, :create, :show]
  resources :spaces
  resources :reservations

  resources :subscriptions

  resources :payments do
    collection do
      post 'paid_users', to: 'payments#post_paid_users'
      post "rnoti", :to => "payments#rnoti"
      get 'result', :to => "payments#result"
    end
  end

  # tmp 
  get 'confirmation_instructions', :to => "mails#confirmation_instructions"
  get 'email_changed', :to => "mails#email_changed"
  get 'password_change', :to => "mails#password_change"
  get 'reset_password_instructions', :to => "mails#reset_password_instructions"
  get 'unlock_instructions', :to => "mails#unlock_instructions"



  # my pages
  get 'my/inquiries'

  # static pages
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
    resources :user_deletions

    resources :inquiries

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

    resources :payments do
      get 'edit_cancel_status'
    end

    resources :op_items
    resources :policies
    resources :roles
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