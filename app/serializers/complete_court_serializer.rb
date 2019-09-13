class CompleteCourtSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :favorite_count
  has_many :upcoming_games, serializer: SimpleGameSerializer

  link :self do
    court_path(object)
  end
end
