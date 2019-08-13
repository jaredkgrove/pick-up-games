Rails.application.routes.draw do
  resources :squad_players
  resources :squads
  resources :games
  resources :courts
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
