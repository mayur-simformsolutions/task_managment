# frozen_string_literal: true
class TaskSolicitation < ApplicationRecord
  #Assosications
  belongs_to :task
  belongs_to :solicitation
end
