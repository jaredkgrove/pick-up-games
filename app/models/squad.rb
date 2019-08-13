class Squad < ApplicationRecord
    has_many :squad_players
    has_many :players, through: :squad_players
end
