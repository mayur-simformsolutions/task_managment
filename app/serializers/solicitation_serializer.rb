# frozen_string_literal: true
class SolicitationSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description 
end
