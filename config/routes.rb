Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'sessions/new'
  root 'posts#index'
  get 'users/show'
  get '/signup', to: 'users#new'
  get 'users/edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :password_resets, only: %i[new create edit update]
  resources :posts
  resources :posts do
    member do
      get :edit_images
      patch :update_images
    end
  end
end
