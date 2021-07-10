class Solicitation < ApplicationRecord
  has_many :task_solicitations, dependent: :destroy
  has_many :tasks, through: :task_solicitations
end
