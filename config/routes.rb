Rails.application.routes.draw do

  resources :flights, only: [:index]

  resources :airlines, only: [:show]
end
