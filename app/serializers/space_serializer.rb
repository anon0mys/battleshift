class SpaceSerializer < ActiveModel::Serializer
  alias :read_attribute_for_serialization :send
  attributes :coordinates, :status, :ship

  def coordinates
    object.coordinates
  end

  def status
    object.status
  end

  def ship
    object.ship
  end
end
