# frozen_string_literal: true
class LabelSerializer
  include JSONAPI::Serializer
  attributes :id, :name
end
