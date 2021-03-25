Rails.application.routes.draw do
  root 'users#index'
  resources :users, only: :new
  devise_for :users
end
