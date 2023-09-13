Kommandant::Engine.routes.draw do
  resources :searches, only: [:index, :new]
  resources :commands, only: [:show]
end
