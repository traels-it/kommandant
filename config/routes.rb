Kommandant::Engine.routes.draw do
  resources :searches, only: [:index, :new]
end
