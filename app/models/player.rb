class Player < ApplicationRecord
    has_secure_password
    has_many :squad_players, dependent: :destroy
    has_many :squads, through: :squad_players
    has_many :admin_squads, -> {merge(SquadPlayer.admin)}, :source => :squad, through: :squad_players
    has_many :game_players, dependent: :destroy
    has_many :games, through: :game_players
    has_many :favorites, dependent: :destroy
    has_many :courts, through: :games
    has_many :favorite_courts, through: :favorites, source: :court

    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true, on: [:create]

    def self.find_or_create_by_omniauth_hash(auth_hash)
        self.where(email: auth_hash[:info][:email]).first_or_create do |player|
            player.name = auth_hash[:info][:name] if !player.name
            player.password = SecureRandom.hex
        end
    end

    def upcoming_games
        self.games.where("time > ?", Time.zone.now).order(time: "ASC")
    end

    def join_game(game)
        game.add_player(self)
    end

    # def create_game_from_hash(game_hash)
    #     self.games.new(game_hash).tap do |game|
    #         game.make_admin(self) if game.save
    #     end
    # end

    # def create_squad_from_hash(squad_hash)
    #     self.squads.build(squad_hash) #do |squad|
    #         #squad.make_admin(self) if squad.save
    #     #end
    # end

    def add_favorite(court)
        self.favorites.find_or_create_by(court:court)
    end

    def remove_favorite(court)
        self.favorites.find_or_create_by(court:court).destroy
    end

    def is_admin_of?(game_or_squad)
        !!game_or_squad.admins.find_by(id: self.id)
    end
end
