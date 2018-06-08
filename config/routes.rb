Rails.application.routes.draw do
  # get 'profiles/show'
  # get 'profiles/edit'
  root to: 'posts#index'

  get 'users/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/auth/:provider/callback', to: 'sessions#create'


  resources :posts, only: [:create, :show, :edit, :update, :index, :destroy]
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]

  resources :profiles, only: [:show, :edit, :update]
  resources :requests, only: [:create, :update, :index]

end
