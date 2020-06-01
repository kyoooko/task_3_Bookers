Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users
  resources :users, only: [:show, :edit, :index,:update]
  
  resources :books, only: [:show, :edit, :index, :update, :create, :destroy] do
    resources :book_comments, only: [:create, :destroy]
  end


end
