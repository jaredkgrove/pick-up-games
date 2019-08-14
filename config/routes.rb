Rails.application.routes.draw do
  root "welcome#home"

  resources :squads, only: [:index, :show, :new, :create, :update, :destroy]

  resources :courts, only: [:index, :show] do
    resources :games, only: [:show, :new, :edit, :create, :update, :destroy]
  end

  resources :players, only: [:show, :new, :create, :edit, :update] 

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  post '/sessions', to: 'sessions#create'

  get '/auth/facebook/callback' => 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
