class GameCourtSerializer < ActiveModel::Serializer
  attributes :id, :name
  
  # link :court do
  #   court_path(object.court)
  # end
end
