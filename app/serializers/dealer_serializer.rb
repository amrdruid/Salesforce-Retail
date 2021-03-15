class DealerSerializer
  include JSONAPI::Serializer
  attributes :name, :category, :sf_id, :longitude, :latitude
end
