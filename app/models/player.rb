class Player < ApplicationRecord
    has_many :squad_players
    has_many :squads, through: :squad_players
    has_many :game_players
    has_many :games, through: :game_players
    has_many :favorites
    has_many :courts, through: :games
    has_many :favorite_courts, through: :favorites, source: :court

    def create_game(court, time)
        new_game = self.games.create(court: court, time: time)
        new_game.make_admin(self)
    end

    def create_squad(name)
        new_squad = self.squads.create(name:name)
        new_squad.make_admin(self)
    end

    def add_favorite(court)
        self.favorites.find_or_create_by(court:court)
    end

    def remove_favorite(court)
        self.favorites.find_or_create_by(court:court).destroy
    end
end
