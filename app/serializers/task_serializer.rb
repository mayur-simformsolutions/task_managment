# frozen_string_literal: true
class TaskSerializer
  include JSONAPI::Serializer  
  attributes :id, :title, :due_date, :description, :status

  attribute :creator do |task|
    task.creator.full_name
  end

  attribute :assignees do |task|
    UserSerializer.new(task.users).serializable_hash[:data].map {|user| user[:attributes]}
  end

  attribute :comments do |task|
    CommentSerializer.new(task.comments).serializable_hash[:data].map {|comment| comment[:attributes]}
  end

  attribute :labels do |task|
    LabelSerializer.new(task.labels).serializable_hash[:data].map {|label| label[:attributes]}
  end

  attribute :documents do |task|
    DocumentSerializer.new(task.documents).serializable_hash[:data].map {|doc| doc[:attributes]}
  end

  attribute :versions do |task|
     VersionSerializer.new(task.versions).serializable_hash[:data].map {|version| version[:attributes]}
  end
end
  