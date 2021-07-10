class TaskSolicitation < ApplicationRecord
  belongs_to :task
  belongs_to :solicitation
end
