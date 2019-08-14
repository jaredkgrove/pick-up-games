class Game < ApplicationRecord
    belongs_to :court
    has_many :game_players
    has_many :players, through: :game_players, dependent: :destroy
    validates :time, presence: true
    validates :court, presence: true

    def player_count
        self.players.count
    end

    def has_admin?
        !admins.empty?
    end

    def admins
        self.players.joins(:squad_players).where(squad_players: {admin: true})
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
        make_all_admin if !has_admin?
    end

    def make_all_admin
        self.players.each do |player|
            make_admin(player)
        end
    end
    
    def delete_game
        self.destroy
    end
end
