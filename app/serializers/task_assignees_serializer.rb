# frozen_string_literal: true
class TaskAssigneesSerializer
  include JSONAPI::Serializer  

  attribute :first_name do |assignee|
    assignee.user.first_name
  end

  attribute :last_name do |assignee|
    assignee.user.last_name
  end

end
  