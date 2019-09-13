class SimpleCourtSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :upcoming_game_count

  def upcoming_game_count
    object.upcoming_games.count
  end

  link :self do
    court_path(object)
  end
end
