Rails.application.routes.draw do
  get 'searches/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root :to => "homes#top"
  get "home/about" => "homes#about"
  get "searches" => "searches#search"
  get "searches/category" => "searches#search_category"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    collection do
      get "sorts" => "sorts#sort"
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end

    get "search" => "count_searches#search"

    resource :relationships, only: [:create, :destroy]
    resources :rooms, only: [:create, :show] do
      resources :direct_messages, only: [:create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :room_relations,only: [:create,:destroy]
  resources :groups do
    resource :group_members, only: [:create, :destroy]
    resources :group_mails, only: [:create, :new]
  end
end
