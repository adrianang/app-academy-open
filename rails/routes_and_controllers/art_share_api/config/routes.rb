Rails.application.routes.draw do
  resources :users do
    resources :artworks, only: [:index]
  end

  resources :users, only: [:show, :create, :update, :destroy]

  # Routes written out below for deeper understanding
  # get 'users', to: 'users#index', as: 'users'
  # post 'users', to: 'users#create'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get 'users/:id', to: 'users#show', as: 'user'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  resources :artworks, only: [:index, :show, :create, :update, :destroy]
  resources :artwork_shares, only: [:create, :destroy]
  resources :comments, only: [:index, :create, :destroy]
end
