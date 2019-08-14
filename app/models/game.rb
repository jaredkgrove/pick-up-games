class Game < ApplicationRecord
    belongs_to :court
    has_many :game_players
    has_many :players, through: :game_players

    def admins
        self.game_players.where(admin: true).collect do |game_player|
            Player.find(game_player.player_id)
        end
    end

    def add_player_as_admin(player)
        self.game_players.find_or_create_by(player:player)
        make_admin(player)
    end

    def add_player(player)
        self.game_players.find_or_create_by(player:player)
    end

    def make_admin(player)
        self.game_players.find_or_create_by(player: player).update(admin: true)        
    end

    def remove_admin(player)
        self.game_players.find_by(player: player).update(admin: false)
    end
end
