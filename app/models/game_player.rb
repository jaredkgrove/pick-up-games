class GamePlayer < ApplicationRecord
    belongs_to :game 
    belongs_to :player
    validates :game, presence: true
    validates :player, presence: true
    scope: admins, -> {where(admin: true)}
end
