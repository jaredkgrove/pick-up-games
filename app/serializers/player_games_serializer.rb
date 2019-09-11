class PlayerGamesSerializer < ActiveModel::Serializer
  include GamesHelper
  attributes :id, :time_text, :court_name
  #belongs_to :court, Serializer: GameCourtSerializer

  # belongs_to :court do
  #   link(:related) { court_path(object.court) }
  #   Serializer = GameCourtSerializer
  # end
  def time_text
    display_date_and_time(object.time)
  end

  link :court do
    court_path(object.court)
  end

  link :self do
    court_game_path(object.court, object)
  end
end
