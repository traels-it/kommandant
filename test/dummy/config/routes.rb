Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:create]
  mount Kommandant::Engine => "/kommandant"

  root to: "users#index"
end
