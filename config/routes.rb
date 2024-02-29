# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  get 'show', to: 'pages#show'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  delete 'movies/:id', to: 'movies#destroy', as: 'movie'

  resources :buckets

  resources :users
end
