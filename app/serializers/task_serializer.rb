# frozen_string_literal: true
class TaskSerializer
  include JSONAPI::Serializer  
  attributes :id, :title, :due_date, :description, :status

  attribute :assignees do |task|
    TaskAssigneesSerializer.new(task.task_assignees).serializable_hash[:data].map {|assignee| assignee[:attributes]}
  end

  attribute :versions do |task|
     VersionSerializer.new(task.versions).serializable_hash[:data].map {|version| version[:attributes]}
  end
end
  