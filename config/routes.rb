Rails.application.routes.draw do
  devise_for :users
<<<<<<< HEAD
  resources :users, only:[:show, :index, :edit, :update,]
  resources :books do
  	resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
=======
  resources :users,only: [:show,:index,:edit,:update,]
  resources :books
>>>>>>> origin/master
  root 'home#top'
  get 'home/about' => 'home#about'
  end