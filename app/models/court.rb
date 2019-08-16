class Court < ApplicationRecord
    has_many :games
    has_many :favorites, dependent: :destroy
    has_many :players, through: :favorites 
    validates :location, presence: true
    validates :name, presence: true

    def upcoming_games
        self.games.where("time > ?", Time.zone.now).order(time: "ASC")
    end

    def favorite_count
        self.favorites.count
    end

    def is_favorite?(player)
        !!self.favorites.find_by(player: player)
    end

    def add_favorite(player)
        self.favorites.find_or_create_by(player:player)
    end

    def remove_favorite(favorite)
        favorite.destroy
    end

    def add_or_remove_favorite(player)
        favorite = self.favorites.find_by(player:player)
        if favorite
            remove_favorite(favorite)
        else
            self.add_favorite(player)
        end
    end

end
