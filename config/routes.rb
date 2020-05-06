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

  resources :shopping_carts
  put '/shopping_carts/:id/confirm', to: 'shopping_carts#confirm', as: 'confirm_shopping_cart'
  put '/shopping_carts/:id/deliver', to: 'shopping_carts#deliver', as: 'deliver_shopping_cart'
  resources :orders

end
