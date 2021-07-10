# frozen_string_literal: true
class TaskAssignee < ApplicationRecord
  #Assosications
  belongs_to :user
  belongs_to :task
end
