class SolicitationSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description 
end
