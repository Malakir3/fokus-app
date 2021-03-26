Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: :new
  resources :menus, only: [:index, :new, :create]
end
