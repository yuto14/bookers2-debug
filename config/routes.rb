Rails.application.routes.draw do
  devise_for :users
<<<<<<< HEAD
  resources :users, only:[:show, :index, :edit, :update,]

=======
<<<<<<< HEAD
  resources :users, only:[:show, :index, :edit, :update,]
>>>>>>> origin/master
  resources :books do
  	resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
<<<<<<< HEAD

  root 'home#top'
  get 'home/about' => 'home#about'

  get 'users/:id/followers' => 'relationships#followers', as: 'followers'
  get 'users/:id/follows' => 'relationships#follows', as: 'follows'
  post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
 end
=======
=======
  resources :users,only: [:show,:index,:edit,:update,]
  resources :books
>>>>>>> origin/master
  root 'home#top'
  get 'home/about' => 'home#about'
  end
>>>>>>> origin/master
