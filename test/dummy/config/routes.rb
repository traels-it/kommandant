Rails.application.routes.draw do
  resources :users
  mount Kommandant::Engine => "/kommandant"

  root to: "users#index"
end
