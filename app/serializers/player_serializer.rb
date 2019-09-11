class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :squads, serializer: PlayerSquadsSerializer
  has_many :admin_squads, serializer: PlayerSquadsSerializer
  has_many :upcoming_games, serializer: PlayerGamesSerializer
  #links(:player)
  #has_many :games, serializer: PlayerSquadsSerializer
  # def links
  #   { self: player_path(object.id) }
  # end

end
