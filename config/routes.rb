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

    resources :users

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
  end
end