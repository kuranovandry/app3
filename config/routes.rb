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
  end
  resources :categories
  root to: 'home#index'
end
