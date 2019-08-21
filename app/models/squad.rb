class Squad < ApplicationRecord
    has_many :squad_players, dependent: :destroy
    has_many :players, through: :squad_players
    has_many :admins, -> { merge(SquadPlayer.admin) }, :source => :player, :through => :squad_players
    validates :name, presence: true
    validates :name, uniqueness: true
    scope :popular_squads, -> {joins(:squad_players).group(:id).order(Arel.sql 'COUNT(squad_id) DESC').limit(3)}

    def is_in_squad?(player)
        self.players.find_by(id: player.id)
    end

    def player_count
        self.players.count
    end

    def has_admin?
        !admins.empty?
    end

    def add_player_as_admin(player)
        add_player(player)
        self.make_admin(player)
    end

    def add_or_remove_player(player)
        squad_player = self.squad_players.find_by(player:player)
        if squad_player
            remove_admin(player) if player.is_admin_of?(self)
            squad_player.destroy
            delete_squad if self.player_count == 0
            
        else
            add_player(player)
        end
    end

    def make_admin(player)
        self.squad_players.find_or_create_by(player: player).update(admin: true)        
    end

    def remove_admin(player)
        self.squad_players.find_by(player: player).update(admin: false)
        self.make_all_admin if !self.has_admin?
    end

    def make_all_admin
        self.players.each do |player|
            make_admin(player)
        end
    end

    def squad_name
        self.squad.name
    end

    private
    def delete_squad
        self.destroy
    end
    
    def add_player(player)
        self.squad_players.find_or_create_by(player:player)
    end
end
