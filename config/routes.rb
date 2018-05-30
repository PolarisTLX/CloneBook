Rails.application.routes.draw do
  # get 'profiles/show'
  # get 'profiles/edit'
  get 'users/show'
  get 'users/index'
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  get 'posts/index'
  get 'posts/show'

  root to: 'posts#index'

  resources :posts
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]

  resources :profiles, only: [:show, :edit, :update]

  #devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
