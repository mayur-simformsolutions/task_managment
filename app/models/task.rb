# frozen_string_literal: true
class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :task_assignees, dependent: :destroy

  enum status: [:incompleted , :inprogress, :completed, :archive].freeze
end
