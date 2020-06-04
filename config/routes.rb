Rails.application.routes.draw do
  devise_for :users
  resources :users, only:[:show, :index, :edit, :update,]

  resources :users, only:[:show, :index, :edit, :update,]

  resources :books do
  	resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]


  root 'home#top'
  get 'home/about' => 'home#about'

  get 'users/:id/followers' => 'relationships#followers', as: 'followers'
  get 'users/:id/follows' => 'relationships#follows', as: 'follows'
  post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'

  resources :users,only: [:show,:index,:edit,:update,]
  resources :books

  root 'home#top'
  get 'home/about' => 'home#about'
  end

