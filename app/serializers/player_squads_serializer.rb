class PlayerSquadsSerializer < ActiveModel::Serializer
  attributes :name, :player_count#, :admins, :player_count
  link :self do
    squad_path(object)
  end
end
