# frozen_string_literal: true
class TaskSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :id, :title, :due_date, :description, :status

end
  