class PlayerGamesSerializer < ActiveModel::Serializer
  attributes :id, :time, :court_name
  #belongs_to :court, Serializer: GameCourtSerializer

  # belongs_to :court do
  #   link(:related) { court_path(object.court) }
  #   Serializer = GameCourtSerializer
  # end
  link :court do
    court_path(object.court)
  end

  link :self do
    court_game_path(object.court, object)
  end
end
