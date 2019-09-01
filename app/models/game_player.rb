class GamePlayer < ApplicationRecord
    belongs_to :game, inverse_of: :game_players
    belongs_to :player, inverse_of: :game_players
    validates :game, presence: true
    validates :player, presence: true

    scope :admin, -> {where(admin: true)}
end
