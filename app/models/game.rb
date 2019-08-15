class Game < ApplicationRecord
    belongs_to :court
    has_many :game_players
    has_many :players, through: :game_players, dependent: :destroy
    has_many :admins, -> { merge(GamePlayer.admin) }, :source => :player, :through => :game_players
    validates :time, presence: true
    validates :court, presence: true
    validates :skill_level, inclusion: { in: ["Everyone Welcome", "Weekend Hustlers", "Offseason Reps", "Run the Court (Girls)", "Still Got It"] }
    validate :game_time_cannot_be_in_the_past

    def self.skill_level_array
        ["Everyone Welcome", "Weekend Hustlers", "Offseason Reps", "Run the Court (Girls)", "Still Got It"]
    end

    def game_time_cannot_be_in_the_past
      if time.present? && time < Time.zone.now
        errors.add(:time, "can't be in the past")
      end
    end 

    def is_in_game?(player)
        self.players.find(player.id)
    end

    def player_count
        self.players.count
    end

    def has_admin?
        !admins.empty?
    end

    def add_player_as_admin(player)
        self.add_player(player)
        make_admin(player)
    end

    def add_player(player)
        self.game_players.find_or_create_by(player:player)
    end

    def add_or_remove_player(player)
        game_player = self.squad_players.find_by(player:player)
        if game_player
            game_player.destroy
        else
            self.player_count == 0 ? self.add_player_as_admin(player) : self.add_player(player)
        end
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
