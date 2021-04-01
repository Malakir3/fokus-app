Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:new, :show]
  resources :standards, only: :index
  resources :intakes, only: :index
  resources :menus do
    resources :standards, except: :index
    resources :intakes, except: :index
  end
end
