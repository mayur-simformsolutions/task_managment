# frozen_string_literal: true
class TaskSerializer
  include JSONAPI::Serializer  
  attributes :id, :title, :due_date, :description, :status

  attribute :assignees do |task|
    UserSerializer.new(task.users).serializable_hash[:data].map {|user| user[:attributes]}
  end

  attribute :labels do |task|
    LabelSerializer.new(task.labels).serializable_hash[:data].map {|label| label[:attributes]}
  end

  attribute :documents do |task|
    DocumentSerializer.new(task.documents).serializable_hash[:data].map {|doc| doc[:attributes]}
  end

  attribute :solicitations do |task|
    SolicitationSerializer.new(task.solicitations).serializable_hash[:data].map {|solicitation| solicitation[:attributes]}
  end
end
  