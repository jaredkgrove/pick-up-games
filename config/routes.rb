Rails.application.routes.draw do
  resources :squads, only: [:index, :show, :new, :create, :update, :destroy]

  resources :courts, only: [:index, :show] do
    resources :games, only: [:show, :new, :edit, :create, :update, :destroy]
  end

  resources :players, only: [:show, :new, :create, :edit, :update] 
  # resources :games
  # resources :courts
  # resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
