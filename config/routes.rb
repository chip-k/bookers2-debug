Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  
  root :to => "homes#top"
  get "home/about" => "homes#about"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  
  get "search" => "searches#search"
  get "search_book" => "books#search_book"
  
  resources :chats, only: [:create, :show]
  
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end