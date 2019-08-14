class Court < ApplicationRecord
    has_many :games
    has_many :favorites
    has_many :players, through: :favorites
    validates :location, presence: true
    validates :name, presence: true
end
