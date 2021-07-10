# frozen_string_literal: true
class VersionSerializer
  include JSONAPI::Serializer  

  attribute :history do |histroy|
    "#{histroy.user.first_name} has #{histroy.event}"
  end
end
  