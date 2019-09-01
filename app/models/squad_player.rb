class SquadPlayer < ApplicationRecord
    belongs_to :squad, inverse_of: :squad_players
    belongs_to :player, inverse_of: :squad_players
    validates :player, presence: true
    validates :squad, presence: true
    scope :admin, -> { where(admin: true) }
end
