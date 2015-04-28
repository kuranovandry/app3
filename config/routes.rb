Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users do
    member do  
      get 'welcome'
    end 
  end
  root :to => 'users#index'
end
