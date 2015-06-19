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
    resources :tickets, only: :index
  end

  resources :tickets, only: :show do
    post :add_to_cart, on: :member
  end
  resources :cart_items, only: :destroy
  resource :cart, only: %i(show destroy)
  resources :orders, only: :create
  resources :categories
  root to: 'home#index'
end
