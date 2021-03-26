Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: :new
  resources :menus do
    resources :standards
  end
end
