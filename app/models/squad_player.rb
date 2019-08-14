class SquadPlayer < ApplicationRecord
    belongs_to :squad 
    belongs_to :player
    validates :player, presence: true
    validates :squad, presence: true

    scope :admin, -> { where(admin: true) }
end
