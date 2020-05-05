Rails.application.routes.draw do
  devise_for :users, controllers: {
        confirmations: 'users/confirmations'
      }

  ActiveAdmin.routes(self)
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  
  root to: "home#index"
  resources :categories
  resources :brands
  resources :products

end
