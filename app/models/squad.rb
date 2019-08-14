class Squad < ApplicationRecord
    has_many :squad_players
    has_many :players, through: :squad_players
    #has_many :admins, class_name: :player, through: :squad_players

    def admins
        self.squad_players.where(admin: true).collect do |squad_player|
            Player.find(squad_player.player_id)
        end
    end

    def add_player_as_admin(player)
        self.squad_players.find_or_create_by(player:player)
        make_admin(player)
    end

    def add_player(player)
        self.squad_players.find_or_create_by(player:player)
    end

    def remove_player(player)
        self.squad_players.find_by(player:player).destroy
    end

    def make_admin(player)
        self.squad_players.find_by(player: player).update(admin: true)        
    end

    def remove_admin(player)
        self.squad_players.find_by(player: player).update(admin: false)
    end
end
