Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'sessions/new'
  root 'posts#index'
  get 'users/show'
  get '/signup', to: 'users#new'
  get 'users/edit'
  get    '/login',   to: 'sessions#new'
  get    '/logged_in_user', to: 'sessions#logged_in_user'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :edit_avatar
      patch :update_avatar
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :password_resets, only: %i[new create edit update]
  resources :posts do
    resources :comments, only: [:create, :destroy]
    member do
      get :edit_images
      patch :update_images
    end
  end
  get 'tags/:tag', to: 'posts#search_tags', as: :tag
end
