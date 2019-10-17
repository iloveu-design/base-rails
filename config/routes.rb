Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'

  resources :subscriptions

  namespace :admin do
    root 'subscriptions#index'
    resources :subscriptions
  end
end