Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users
  resources :users, only: [:show, :edit, :index,:update]

  resources :books, only: [:show, :edit, :index, :update, :create, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # フォロー機能
  resources :relationships, only: [:create, :destroy]
  get 'users/:id/follows' => "users#follows"
  get 'users/:id/followers' => "users#followers"
end
