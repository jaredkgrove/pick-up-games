class Player < ApplicationRecord
    has_many :squad_players
    has_many :squads, through: :squad_players
    has_many :game_players
    has_many :games, through: :game_players
    has_many :favorites
    has_many :courts, through: :games
    has_many :favorite_courts, through: :favorites, source: :court

    def join_game(game)
        game.add_player(self)
    end

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

    def is_admin_of?(game_or_squad)
        if game_or_squad.class == Game
            GamePlayer.find_by(player:self, game: game_or_squad).admin
        elsif game_or_squad.class == Squad
            SquadPlayer.find_by(player:self, squad: game_or_squad).admin
        end
    end
end
