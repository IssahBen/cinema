Rails.application.routes.draw do
 
 root "pages#home"

 get "show", to: "pages#show"

 get "login", to: "sessions#new"

 post "login" ,to: "sessions#create"

 delete "logout", to: "sessions#destroy"

 resources :users

 
end
