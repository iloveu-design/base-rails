Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'

  namespace :admin do
    root 'users#index'
    resources :subscriptions
  end
end