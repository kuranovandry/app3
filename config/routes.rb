Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :users do
    member do
      get 'welcome'
      get 'csv_mail'
    end
  end
  resources :projects
  resources :movies do
    resources :uploads
    resources :daily_statistics, only: :index
    resources :monthly_statistics, only: :index
    post :add_to_the_cart, on: :member
  end
  resources :cart_items, only: :destroy
  resource :cart, only: :show
  resources :orders, only: :create
  resources :categories
  resources :tickets, only: :show
  root to: 'home#index'
end
