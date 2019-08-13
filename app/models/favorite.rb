class Favorite < ApplicationRecord
    belongs_to :court
    belongs_to :player
end
