class Player < ApplicationRecord
    has_secure_password
    has_many :squad_players
    has_many :squads, through: :squad_players, dependent: :destroy
    has_many :game_players
    has_many :games, through: :game_players, dependent: :destroy
    has_many :favorites
    has_many :courts, through: :games
    has_many :favorite_courts, through: :favorites, source: :court
    validates :name, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :password, presence: true

    def self.find_or_create_by_omniauth_hash(auth_hash)
        self.where(email: auth_hash[:info][:email]).first_or_create do |player|
            player.name = auth_hash[:info][:name] if !player.name
            player.password = SecureRandom.hex
        end
    end

    def join_game(game)
        game.add_player(self)
    end

    def create_game_from_hash(game_hash)
        self.games.new(game_hash).tap do |game|
            game.make_admin(self) if game.save
        end
    end

    def create_squad(name)
        new_squad = self.squads.create(name: name)
        new_squad.make_admin(self)
        new_squad
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
