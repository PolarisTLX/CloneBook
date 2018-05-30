Rails.application.routes.draw do
  # get 'profiles/show'
  # get 'profiles/edit'
  get 'users/show'
  get 'users/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'posts/index'
  get 'posts/show'
  get '/auth/:provider/callback', to: 'sessions#create'

  root to: 'posts#index'

  resources :posts
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]

  resources :profiles, only: [:show, :edit, :update]
  resources :requests, only: [:create]

end
