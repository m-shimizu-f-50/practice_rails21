Rails.application.routes.draw do
  
  root 'homes#top'
  get 'homes/about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update,:destroy]
  resources :books,only: [:index,:edit,:show,:update,:create,:destroy] do
  	resources :favorites,only: [:create,:destroy]
  end
 

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
