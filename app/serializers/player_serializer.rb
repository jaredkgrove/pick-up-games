class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name#, :is_current_player
  has_many :squads, serializer: PlayerSquadsSerializer
  has_many :admin_squads, serializer: PlayerSquadsSerializer
  has_many :upcoming_games, serializer: PlayerGamesSerializer
  has_many :admin_games, serializer: PlayerGamesSerializer
  has_many :favorite_courts, serializer: SimpleCourtSerializer
  #  def is_current_player
#      def is_current_player
# binding.pry
#      end
  #  end
  #links(:player)
  #has_many :games, serializer: PlayerSquadsSerializer
  # def links
  #   { self: player_path(object.id) }
  # end

end
