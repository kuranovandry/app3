Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users do
    member do
      get 'welcome'
    end 
  end
  resources :projects
  resources :movies
  resources :categories
  root :to => 'users#index'
end
