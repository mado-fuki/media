Rails.application.routes.draw do
  root 'main#home'
  get 'users/show'
  get '/signup', to: 'users#new'
  get 'users/edit'
end
