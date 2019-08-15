class Court < ApplicationRecord
    has_many :games
    has_many :favorites
    has_many :players, through: :favorites
    validates :location, presence: true
    validates :name, presence: true

    def upcoming_games
        self.games.where("time > ?", Time.zone.now).order(time: "ASC")
    end
end
