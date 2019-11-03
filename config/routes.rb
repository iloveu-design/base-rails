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
    resources :policies
    resources :subscriptions
  end
end