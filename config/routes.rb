Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :users do
    member do
      get 'welcome'
    end
  end
  resources :projects
  resources :movies do
    resources :uploads
  end
  resources :categories
  root :to => 'users#index'
end
