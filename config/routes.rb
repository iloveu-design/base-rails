Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :omniauth_callbacks => :omniauth_callbacks
  }

  root 'pages#home'

  resources :subscriptions

  namespace :admin do
    root 'subscriptions#index'
    resources :subscriptions
  end
end