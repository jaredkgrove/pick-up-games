class Favorite < ApplicationRecord
    belongs_to :court
    belongs_to :player
    validates :court, presence: true
    validates :player, presence: true
end