# frozen_string_literal: true
class TaskLabelSerializer
  include JSONAPI::Serializer
  attributes 
  belongs_to :task
  belongs_to :label
end
