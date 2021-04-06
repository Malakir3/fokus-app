Rails.application.routes.draw do
  devise_for :users
  root 'menus#index'
  resources :users, only: [:show]
  resources :standards, only: :index
  resources :intakes, only: :index
  resources :menus do
    resources :standards, except: :index
    resources :intakes, except: :index
  end
  resources :graphs, only:[:index, :create] do
    collection do
      delete 'erase'
    end
  end
end
