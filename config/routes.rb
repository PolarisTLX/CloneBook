Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  devise_for :users
  get 'posts/index'
  get 'posts/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
end
