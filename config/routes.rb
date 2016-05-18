Rails.application.routes.draw do

  root "static_pages#home"

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  
  get "signup" => "users#new"
  
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:index, :show] do
    resources :lessons, only: [:create, :update]
  end
  resources :words, only: [:index]
  resources :lessons, only: [:show, :update, :destroy] do
    resources :results, only: [:index]
  end

  resources :users do
    resources :followers, only: [:index]
    resources :followings, only: [:index]
  end

  namespace :admin do
    root "users#index"
    resources :categories, only: [:new, :create,
      :index, :edit, :update, :destroy] do
      resources :words, only: [:new, :create]
    end
    resources :users, only: [:index, :destroy]
    resources :words, only: [:index, :edit, :update, :destroy]
  end
end
