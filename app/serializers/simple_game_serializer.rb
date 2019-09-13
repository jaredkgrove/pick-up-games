class SimpleGameSerializer < ActiveModel::Serializer
  include GamesHelper
  attributes :id, :time_text, :player_count

  def time_text
    display_date_and_time(object.time)
  end

  link :self do
    court_game_path(object.court, object)
  end
end
