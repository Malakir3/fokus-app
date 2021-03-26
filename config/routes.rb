Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: :new do
    resources :standards, only: :index
  end
  resources :menus do
    resources :standards, except: :index
  end
end
