class Player < ApplicationRecord
    has_many :squad_players
    has_many :squads, through: :squad_players
    has_many :game_players
    has_many :games, through: :game_players
    has_many :favorites

end
