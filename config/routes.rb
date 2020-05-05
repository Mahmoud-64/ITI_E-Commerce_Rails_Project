Rails.application.routes.draw do
  
  resources :shopping_carts
  devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root to: "home#index"
  resources :categories
  resources :brands
  resources :products

  resources :orders

end
