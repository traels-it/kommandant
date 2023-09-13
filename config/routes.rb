Kommandant::Engine.routes.draw do
  resources :searches, only: [:index, :new]
  resources :commands, only: [:show] do
    resource :searches, module: :commands, only: [:show]
  end
end
